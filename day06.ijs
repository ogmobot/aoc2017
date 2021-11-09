#!/usr/bin/ijconsole

input=:,".>cutopen toJ 1!:1<'input06.txt'

mancala=:{{
    NB. From array y, take from index x, then sow from index x+1.
    leftovers=.((#y)|(x{y))>i.(#y)
    NB. (array with x removed) + (even distribution) + (0s and 1s as appropriate)
    (0 x}y) + (<.(x&{%#)y) + ((->:x)|.leftovers)
}}

run_mancala=:{{
    y=.,:y
    while. ((#@~.)=#) y do.
        y=.y,({.@\:@{:y)mancala ({:y)
    end.
    y
}}

result =: run_mancala input
echo <: # result
echo | -/ I. ({:result) */@:="1 result NB. clumsy but it works
exit''
