#!/usr/bin/ijconsole

input=:382

spin=: (input&|.)@,

NB. TODO point free
solve1=: {{
    acc=.(0$0)
    while. #y do.
        acc=.acc spin ({.y)
        y=.}.y
    end.
    acc
}}

echo {. solve1 i.2017

NB.res =: solve i.100000
NB.echo (>:(res i. 0)) { res
NB. takes hours... and hundreds of MBs
NB.   50000 => 1.632s
NB.  100000 => 6.229s
NB. Seems to grow at O(n^2) (not including garbage collection)
NB. so this approach would take us, uh... 19+ days.
NB. Tried a linear approach in LISP, and exhausted the heap. Let's try something else.

NB. Just need to keep track of current_index, current_length, and the number to 0's right.
NB. Let the first item of the list be 0.

solve2=: {{
    current=.0
    length=. 1
    nextval=.0
    for_i. 1 + i. y do.
        NB. i is also the current length of the list
        current=.>:i|current+input
        if. 1=current do.
            nextval=.i
        end.
    end.
    nextval
}}
NB. cleaner... but slower :(
solve3 =: {{
    length =. 0{y
    index  =. 1{y
    nextval=. 2{y
    nextindex=. >:length|index+input
    (>:length),nextindex,(1=nextindex){nextval,length
}}

NB. ~35 seconds
echo solve2 5000000
NB. ~70 seconds
NB.echo {: solve3^:5000000 (1 0 0)
exit''
