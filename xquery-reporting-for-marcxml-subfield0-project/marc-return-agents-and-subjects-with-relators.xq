xquery version "3.0";
declare namespace marc = "http://www.loc.gov/MARC21/slim";

element wrapper {
let $headings := marc:collection/marc:record/marc:datafield[matches(@tag, '^1|^6|^7')][marc:subfield/@code=('e', '4')]

for $x in $headings
let $bib := $x/ancestor::marc:record/marc:controlfield[@tag='001']
return
   <result bib="{$bib}">{$x}</result>
}