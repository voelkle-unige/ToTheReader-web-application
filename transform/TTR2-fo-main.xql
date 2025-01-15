import module namespace m='http://www.tei-c.org/pm/models/TTR2/fo' at 'TTR2-fo.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/TTR2.css"],
    "collection": "/db/apps/tei-publisher/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)