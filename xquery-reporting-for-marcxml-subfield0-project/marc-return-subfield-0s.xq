xquery version "3.0";
declare namespace marc = "http://www.loc.gov/MARC21/slim";

element wrapper {
let $links := marc:collection/marc:record/marc:datafield/marc:subfield[@code="0"]

for $x in distinct-values($links)

      order by count($links[. eq $x]) descending, $x 
        
      return
          <subfield count="{count($links[. eq $x])}">{$x}</subfield>
}


