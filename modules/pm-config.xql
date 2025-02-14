
xquery version "3.1";

module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config";

import module namespace pm-TTR2-web="http://www.tei-c.org/pm/models/TTR2/web/module" at "../transform/TTR2-web-module.xql";
import module namespace pm-TTR2-print="http://www.tei-c.org/pm/models/TTR2/print/module" at "../transform/TTR2-print-module.xql";
import module namespace pm-TTR2-latex="http://www.tei-c.org/pm/models/TTR2/latex/module" at "../transform/TTR2-latex-module.xql";
import module namespace pm-TTR2-epub="http://www.tei-c.org/pm/models/TTR2/epub/module" at "../transform/TTR2-epub-module.xql";
(:  :import module namespace pm-TTR2-fo="http://www.tei-c.org/pm/models/TTR2/fo/module" at "../transform/TTR2-fo-module.xql";:)
import module namespace pm-docx-tei="http://www.tei-c.org/pm/models/docx/tei/module" at "../transform/docx-tei-module.xql";

declare variable $pm-config:web-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "TTR2.odd" return pm-TTR2-web:transform($xml, $parameters)
    default return pm-TTR2-web:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:print-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "TTR2.odd" return pm-TTR2-print:transform($xml, $parameters)
    default return pm-TTR2-print:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:latex-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "TTR2.odd" return pm-TTR2-latex:transform($xml, $parameters)
    default return pm-TTR2-latex:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:epub-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "TTR2.odd" return pm-TTR2-epub:transform($xml, $parameters)
    default return pm-TTR2-epub:transform($xml, $parameters)
            
    
};
            


(:  :declare variable $pm-config:fo-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "TTR2.odd" return pm-TTR2-fo:transform($xml, $parameters)
    default return pm-TTR2-fo:transform($xml, $parameters)
            
    
};:)
            


declare variable $pm-config:tei-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "docx.odd" return pm-docx-tei:transform($xml, $parameters)
    default return error(QName("http://www.tei-c.org/tei-simple/pm-config", "error"), "No default ODD found for output mode tei")
            
    
};
            
    