#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

no_dups=:(#=#@~.)@(' '&strsplit)@>
NB. (/:~&.>) is 'sort under unbox', i.e. unbox, then sort, then box
no_anagrams=:(#=#@~.)@:(/:~&.>)@(' '&strsplit)@>

input=:cutopen toJ 1!:1<'input04.txt'

echo +/ no_dups input
echo +/ no_anagrams input

exit''
