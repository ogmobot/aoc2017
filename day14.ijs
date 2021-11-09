#!/usr/bin/ijconsole

hex=: {&'0123456789abcdef'
xor=: ~:/&.#:@,

hex2bin=: ,@:}.@#:@(8&,)@(hex^:_1)

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

propagate_regions=: (>./@:(((,-)#:i.3) |.!.0]))*(~:&0)
final_regions    =: propagate_regions^:_@(]*>:@i.@$)

getrow=: ((,&'-')@[) (hex2bin@full_hash@(a.&i.)@,) (":@])

input=:'ljoxqyyw'
grid=: input getrow"(1 0) (i.128)

NB. part 1
echo +/^:2 grid
NB. part 2
echo +/ (>&0) ~. , final_regions grid
