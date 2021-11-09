#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

input =: cutopen toJ 1!:1 < 'input18.txt'

NB. registers are a b f i p # * where * is the instruction pointer
NB.sndbufs =: a:,a: NB. initially two empty lists

isreg  =: (e.&'abfip')@{.

NB. x argument should be registers
getreg =: {~('abfip'&i.)@{.

step =: {{
    NB. x is the current state of the registers
    NB. y is the (entire) program
    NB. returns registers ; sndcount ; ret
    NB. where ret is 1 => waiting for 'rcv'
    NB.              0 => otherwise
    ret   =. 0
    sndcount =. 0
    words =. ' ' strsplit > ({:x){y
    xval  =. _.
    select. {.words
    case. <'snd' do.
        id =. 2 | (> 5 { x)   NB. use id=2 for part 1.
        if. isreg > 1 { words do.
            xval =. x getreg > 1 { words
        else.
            xval =. ". > 1 { words
        end.
        sndcount =. 1
        curbuf =. > id { sndbufs
        sndbufs =: (< curbuf, xval) id} sndbufs
    case. <'set' do.
        if. isreg > 2 { words do.
            yval =. x getreg > 2 { words
        else.
            yval =. ". > 2 { words
        end.
        x =. yval ('abfip' i. > 1 { words)} x
    case. <'add' do.
        if. isreg > 2 { words do.
            yval =. x getreg > 2 { words
        else.
            yval =. ". > 2 { words
        end.
        x =. (yval + x getreg > 1 { words) ('abfip' i. > 1 { words)} x
    case. <'mul' do.
        if. isreg > 2 { words do.
            yval =. x getreg > 2 { words
        else.
            yval =. ". > 2 { words
        end.
        x =. (yval * x getreg > 1 { words) ('abfip' i. > 1 { words)} x
    case. <'mod' do.
        if. isreg > 2 { words do.
            yval =. x getreg > 2 { words
        else.
            yval =. ". > 2 { words
        end.
        x =. (yval | x getreg > 1 { words) ('abfip' i. > 1 { words)} x
    case. <'rcv' do.
        id =. 5 { x
        if. id = 2 do.
            NB. part 1
            if. isreg > 1 { words do.
                xval =. x getreg > 1 { words
            end.
            if. xval > 0 do.
                ret =. 1
            end.
        else.
            NB. part 2
            if. 0 < (# (> (-. id) { sndbufs)) do.
                rcvval =. {.@> (-. id) { sndbufs
                sndbufs =: (}.&.> (-. id) { sndbufs) (-. id)} sndbufs
                x =. rcvval ('abfip' i. > 1 { words)} x
            else.
                NB. empty list; wait at this instruction
                x =. (}:,<:@{:) x
                ret =. 1
            end.
        end.
    case. <'jgz' do.
        if. isreg > 1 { words do.
            xval =. x getreg > 1 { words
        else.
            xval =. ". > 1 { words
        end.
        if. isreg > 2 { words do.
            yval =. x getreg > 2 { words
        else.
            yval =. ". > 2 { words
        end.
        if. xval > 0 do.
            x =. (}:,<:@(+&yval)@{:) x
            NB. ip will be incremented later, so decrement it now
        end.
    case. do.
        echo 'error!'
        echo y
    end.
    x =. (}:,>:@{:) x NB. increment ip
    x ; sndcount; ret
}}

solve1 =: {{
    while. 1 do.
        tmp =. x step y
        x =. > {. tmp
        if. > {: tmp do.
            NB. last element of first sndbuf
            break.
        end.
    end.
    {: > {. sndbufs
}}

solve2 =: {{
    r0 =. {. x
    r1 =. {: x
    dead0 =. 0
    dead1 =. 0
    answer =. 0
    while. 1 do.
        NB. machine zero steps until rcv.
        while. 1 do.
            tmp =. r0 step y
            r0 =. > {. tmp
            if. > 1 { tmp do.
                dead1 =. 0
            end.
            if. > {: tmp do.
                NB. wait for other machine
                dead0 =. 1
                break.
            end.
        end.
        NB. machine one steps until rcv
        while. 1 do.
            tmp =. r1 step y
            r1 =. > {. tmp
            if. > 1 { tmp do.
                answer =. >:answer
                dead0 =. 0
            end.
            if. > {: tmp do.
                NB. wait for other machine
                dead1 =. 1
                break.
            end.
        end.
        if. dead0 *. dead1 do.
            break.
        end.
    end.
    answer
}}

NB. part 1
sndbufs =: a:,a:
echo (0 0 0 0 0 2 0) solve1 input

NB. part 2
sndbufs =: a:,a:
echo (0 0 0 0 0 0 0,:0 0 0 0 1 1 0) solve2 input

exit''
