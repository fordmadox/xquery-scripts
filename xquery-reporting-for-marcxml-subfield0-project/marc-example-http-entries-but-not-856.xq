xquery version "3.0";
declare namespace marc = "http://www.loc.gov/MARC21/slim";

element wrapper {
let $http-links := marc:collection/marc:record/marc:datafield/marc:subfield[contains(., 'http')]

for $x in $http-links
let $parent := $x/../@tag, $code := $x/@code, $bib := $x/ancestor::marc:record/marc:controlfield[@tag='001']
where $parent[starts-with(., '1') or starts-with(., '6') or starts-with(., '7')] and $code != '0'
  return
   <subfield code="{$code}" parent="{$parent}" bib="{$bib}">{$x}</subfield>
}