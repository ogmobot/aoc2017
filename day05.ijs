#!/usr/bin/ijconsole

input=:,".>cutopen toJ 1!:1<'input05.txt'

run_prog=:{{
    0 run_prog y
    :
    ip=.0
    steps=.0
    while. ip < (# y) do.
        val=.ip{y
        if. x *. val >: 3 do.
            NB. part 2
            y=.(<:val) ip}y
        else.
            NB. ordinary case
            y=.(>:val) ip}y
        end.
        ip=.ip+val
        steps=.>:steps
    end.
    steps
}}

echo run_prog input
echo 1 run_prog input
exit''
