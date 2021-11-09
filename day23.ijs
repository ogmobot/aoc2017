#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

NB. registers are a b c d e f g * where * is the instruction pointer

isreg  =: (e.&'abcdefgh')@{.

NB. x argument should be registers
getreg =: {~('abcdefgh'&i.)@{.

step =: {{
    NB. x is the current state of the registers
    NB. y is the (entire) program
    NB. returns registers ; mulcount ; ret
    NB. where ret is 1 => halted
    NB.              0 => otherwise
    if. ({:x) >: #y do.
        x ; 0 ; 1
    else.
        mulcount =. 0
        words =. ' ' strsplit > ({:x){y
        xval  =. _.
        select. {.words
        case. <'set' do.
            if. isreg > 2 { words do.
                yval =. x getreg > 2 { words
            else.
                yval =. ". > 2 { words
            end.
            x =. yval ('abcdefgh' i. > 1 { words)} x
        case. <'add' do.
            if. isreg > 2 { words do.
                yval =. x getreg > 2 { words
            else.
                yval =. ". > 2 { words
            end.
            x =. (yval + x getreg > 1 { words) ('abcdefgh' i. > 1 { words)} x
        case. <'sub' do.
            if. isreg > 2 { words do.
                yval =. x getreg > 2 { words
            else.
                yval =. ". > 2 { words
            end.
            NB. note this is "X decreases by Y"
            x =. (- yval - x getreg > 1 { words) ('abcdefgh' i. > 1 { words)} x
            NB.if. 'b' = 0 } (> 1 { words) do.
                NB.echo 'b';(- yval - x getreg > 1 { words)
            NB.end.
        case. <'mul' do.
            if. isreg > 2 { words do.
                yval =. x getreg > 2 { words
            else.
                yval =. ". > 2 { words
            end.
            x =. (yval * x getreg > 1 { words) ('abcdefgh' i. > 1 { words)} x
            mulcount =. 1
        case. <'jnz' do.
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
            if. xval ~: 0 do.
                x =. (}:,<:@(+&yval)@{:) x
                NB. ip will be incremented later, so decrement it now
            end.
        case. do.
            echo 'error!'
            echo y
        end.
        x =. (}:,>:@{:) x NB. increment ip
        x ; mulcount; 0
    end.
}}

solve =: {{
    mulcounter =. 0
    while. 1 do.
        tmp =. x step y
        if. > 2 { tmp do. NB. the halt signal
            break.
        else.
            mulcounter =. mulcounter + (> 1 { tmp)
            x =. > 0 { tmp
        end.
    end.
    x ; mulcounter
}}

input =: cutopen toJ 1!:1 < 'input23.txt'

NB. part 1
NB.        a b c d e f g h *
echo > {: (0 0 0 0 0 0 0 0 0) solve input

NB. part 2... in theory. In practice, takes too long.
NB.                 a b c d e f g h *
NB. echo 7 { (> {. (1 0 0 0 0 0 0 0 0) solve input)

NB. Here's the program that part 2 is carrying out:
nums =: 106700 + 17 * i. 1001
isprime =: (1&=)@#@q:
echo # (#~ -.@isprime) nums

NB. ===REGISTERS===
NB. part 1/2   candidate  maxnum factor1 factor2 flag scratch compositecount
NB.     a          b        c       d      e      f      g         h
NB. We can effect a big speedup by changing `16 set f 0` (which sets a flag to
NB. increment h) to `16 jnz 1 10` (which jumps out of the loop, straight to where
NB. h is being incremented) and changing `19 sub g b` to `19 sub g d`, which ensures
NB. that each possible pair of factors is tested only once.
NB. This makes finding composite numbers much faster; but finding primes is still very slow.
NB. If I had left the "jgz" command in, we could get a good speedup by skipping
NB. remaining factors as soon as (d * e) > b. This might require recalculating jumps.

new_program =: ((<'jnz 1 10'),(<'sub g d')) (15 18)} input
NB. echo 7 { (> {. (1 0 0 0 0 0 0 0 0) solve new_program)

exit''
