#!/usr/bin/ijconsole

hex=: {&'0123456789abcdef'
xor=: ~:/&.#:@,

single_round=: {{
    seq=. i. 256
    idx=. 0
    skp=. 0
    while. 0<#y do.
        val=. {.y
        seq=. ((|.@(val&{.)),(val&}.))&.(idx&|.) seq
        idx=. (#seq)|idx+skp+val
        skp=. >:skp
        y  =. }.y
    end.
    seq
}}

full_hash=: {{
    NB. ~^:6 will double the length of its argument 6 times
    sparse=. single_round (,~^:6 (y,17,31,73,47,23))
    dense=.  xor/"1 (_16]\ sparse)
    , hex ((16 16)&#:) dense
}}

input=:>cutopen toJ 1!:1<'input10.txt'
NB. part 1
result=: single_round (,".input)
echo */ 0 1 { result
NB. part 2
echo full_hash (a.&i.) ,input

exit''
