xquery version "3.1";

module namespace idx="http://teipublisher.com/index";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace dbk="http://docbook.org/ns/docbook";

declare variable $idx:app-root :=
    let $rawPath := system:get-module-load-path()
    return
        (: strip the xmldb: part :)
        if (starts-with($rawPath, "xmldb:exist://")) then
            if (starts-with($rawPath, "xmldb:exist://embedded-eXist-server")) then
                substring($rawPath, 36)
            else
                substring($rawPath, 15)
        else
            $rawPath
    ;
    

declare function idx:formatDate($input as xs:string?) as xs:date? {
    if(empty($input))
        then ()
        else
            let $i := normalize-space(replace($input, '&#160;', ' '))
            let $date := if (matches($i,'^(\d{4}-\d{2}-\d{2}).*')) 
                    then xs:date($i) 
                    else if (matches($i,'^(\d{4})$')) then xs:date($i || '-01-01')
                        else if (matches($i,'^(\d{4}-\d{2})$')) then xs:date($i || '-01')
                            else ()
    return $date
};


(:~
 : Helper function called from collection.xconf to create index fields and facets.
 : This module needs to be loaded before collection.xconf starts indexing documents
 : and therefore should reside in the root of the app.
 :)
declare function idx:get-metadata($root as element(), $field as xs:string) {
    let $header := $root/tei:teiHeader
    return
        switch ($field)
            case "title" return (
                    $header//tei:fileDesc/tei:titleStmt/tei:title
                )
            case "sourceTitle" return (
                    $header//tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title
                )
            case "author" return (
                    $header//tei:fileDesc/tei:titleStmt/tei:author
                )
            case "printer" return
                head((
                    $header//tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:publisher
                ))
            case "publisher" return
                head((
                    $header//tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:distributor
                ))
            case "date" return (
                    idx:formatDate($header//tei:editionStmt/tei:edition/tei:date)
                )
            case "category" return (
                    $header//tei:textClass/tei:keywords[@scheme="TTR Div type Categories"]/tei:term
                )
            case "language" return
                head((
                    $header//tei:langUsage/tei:language,
                    $root/@xml:lang,
                    $header/@xml:lang
                ))
            case "USTCsubcat" return
                head((
                    $header//tei:keywords[@scheme="USTC Subject Classification"]/tei:term
                ))    
            default return
                ()
};







declare function idx:get-genre($header as element()?) {
    for $target in $header//tei:textClass/tei:catRef[@scheme="#genre"]/@target
    let $category := id(substring($target, 2), doc($idx:app-root || "/data/taxonomy.xml"))
    return
        $category/ancestor-or-self::tei:category[parent::tei:category]/tei:catDesc
};
