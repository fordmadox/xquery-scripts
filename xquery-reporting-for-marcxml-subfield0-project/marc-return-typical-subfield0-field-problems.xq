xquery version "3.0";
declare namespace marc = "http://www.loc.gov/MARC21/slim";

element wrapper {
let $links := marc:collection/marc:record/marc:datafield/marc:subfield[@code="0"]

for $x in $links
let $parent := $x/../@tag, $code := $x/@code, $bib := $x/ancestor::marc:record/marc:controlfield[@tag='001']
where $x/normalize-space() and 
$x[contains(., 'htm') or contains(., 'rwo') or not(starts-with(., 'http')) or ends-with(., '.')]
order by $bib, $parent, $x
  return
   <subfield code="{$code}" parent="{$parent}" bib="{$bib}">{$x}</subfield>
}