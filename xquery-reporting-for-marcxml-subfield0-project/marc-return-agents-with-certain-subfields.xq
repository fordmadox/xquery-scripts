xquery version "3.0";
declare namespace marc = "http://www.loc.gov/MARC21/slim";

element wrapper {
(: abstract this later to return a report on different fields used in the MARC database :)
let $headings := marc:collection/marc:record/marc:datafield[@tag = ('100', '110', '111', '130', '600', '610', '611', '630', '692', '693', '700', '710', '711', '730', '740')][marc:subfield/@code=('f', 'h', 'i', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 't', 'v', 'x', 'g', 'y', 'z', '1', '2', '3', '5', '6', '7', '8')]

for $x in $headings
let $bib := $x/ancestor::marc:record/marc:controlfield[@tag='001']
, $heading := $x
where $x[not(marc:subfield[@code='0'])]
group by $x
order by $heading[1]/marc:subfield[@code='a']
return
   <result bib="{string-join($bib, ', ')}">{$heading[1]}</result>
}