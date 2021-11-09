#!/usr/bin/ijconsole

getvals=: {{
    colon=.y i.':'
    (". colon {. y), ". (>:colon) }. y
}}

collision=: (+:@<:@[) ((0&=)@|) ]

severity=: {{
  +/ ((1{"1 y) collision (0{"1 y)) # (*/"1 y)
}}

count_collisions=: {{
    +/ ((1{"1 y) collision (x+0{"1 y))
}}

NB. echo +/ (3 2 4 4) collision (0 1 4 6)

NB.input=:0 3,1 2,4 4,:6 4
input=: getvals@> cutopen toJ 1!:1<'input13.txt'

echo severity input
NB. takes about a minute to run
maxnum =: 5000000
echo ((count_collisions&input)&.> <"0 i.maxnum) i. <0

exit''
