xquery version "3.0";
declare namespace marc = "http://www.loc.gov/MARC21/slim";

element wrapper {
let $records := marc:collection/marc:record

for $x in $records
let $bib := $x/marc:controlfield[@tag='001']
, $total-headings := $x/marc:datafield[matches(@tag, '^1|^6|^7')]
, $count := count($total-headings)
, $tags := distinct-values($total-headings/@tag)
, $marc100 := $total-headings[@tag='100']
(: is there a better way to get these counts with a function, i bet? :)

order by $count descending
return
   <result bib="{$bib}" total-headings="{$count}">
     {
       for $tag in $tags 
       return 
       attribute {concat('marc_', $tag)} {count($total-headings[@tag=$tag])}
     }
   </result>

}