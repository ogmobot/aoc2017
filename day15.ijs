#!/usr/bin/ijconsole

prng=: (2147483647&|)@*
genA=: 16807&prng
genB=: 48271&prng
NB. a and b from input
initA=: 703
initB=: 516

part1=: {{
    NB. A more natural way to solve this would be to generate two arrays via iteration.
    NB. However, for n=40M, this costs a lot of space. We'll iterate instead.
    a =. initA
    b =. initB
    total =. 0
    for. i.y do.
        a =. genA a
        b =. genB b
        total =. total + (a (=&:(65536&|)) b)
    end.
    total
}}

part2=: {{
    a =. initA
    b =. initB
    total =. 0
    for. i.y do.
        whilst. 4|a do.
            a =. genA a
        end.
        whilst. 8|b do.
            b =. genB b
        end.
        total =. total + (a (=&:(65536&|)) b)
    end.
    total
}}

NB. each part takes ~45 seconds
NB. echo part1 40000000
echo part2 5000000
exit''
