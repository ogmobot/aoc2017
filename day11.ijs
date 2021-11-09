#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

codes=: ':' strsplit 'n:ne:se:s:sw:nw'
coords=: 0 1 1, 1 1 0, 1 0 _1, 0 _1 _1, _1 _1 0,: _1 0 1

code2coord=: (,@(#&coords)@(=&codes))
distance  =: -:@(+/)@:|

input=: ',' strsplit > {. cutopen toJ 1!:1 < 'input11.txt'
path =: code2coord"0 input

echo distance +/ path
echo >./ distance"1 +/\ path

exit''
