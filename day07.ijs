#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

line2boxes=: {{
    NB. remove commas
    y=. (-.@:(','&=)#]) y
    words=. ' ' strsplit y
    if. +/ '>'=y do.
        ({.words),(".>(1{words));<(}.^:3 words)
    else.
        ({.words),(".>(1{words));<a:
    end.
}}

getdata=: {{
    NB. TODO? rewrite this as point-free
    ,((<y)=({."1 data)) # data
}}

totalweight=: {{
    if. (#y)=0 do.
        0
    else.
        NB. x is name, y is data
        record=. getdata y
        (> 1 { record) + (+/ (totalweight@> (> 2 { record)))
    end.
}}

allweights =: {{
    record =. getdata y
    weighttab =. ((],.totalweight&.>) (> 2 { record))
    ('*intr*';(> 1 { record)),((((>&0)@>@(1&{))"1 weighttab) # weighttab)
}}

input=:>cutopen toJ 1!:1<'input07.txt'
data=: line2boxes"1 input

NB. part 1
all_names=: /:~ ~.(0}"1 data)
all_children=: }. /:~ ~. , >(2}"1 data)
echo > (I. -. (all_names e. all_children)) { all_names

NB. part 2
NB. Inspect data with allweights <string>, starting with part 1's answer.
NB. By inspection, the intrinsic weight of node 'ptshtrn' unbalances the tree.
