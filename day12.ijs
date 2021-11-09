#!/usr/bin/ijconsole

line_update=: {{
    NB. update distances matrix based on a line of text like '2 <-> 0, 3, 4'
    NB. distance=: 1 (<row col)} distance
    first_space =. ' 'i.~>y
    last_skip   =. '>'i.~>y
    row         =. ". first_space{.>y
    nums        =. ". (>:last_skip)}.>y
    adjacent    =: (((i.size) e. nums)) row} adjacent
    0
}}

input=: cutopen toJ 1!:1 < 'input12.txt'
NB.input=: (<'0 <-> 2'),(<'1 <-> 1'),(<'2 <-> 0, 3, 4'),(<'3 <-> 2, 4'),(<'4 <-> 2, 3, 6'),(<'5 <-> 6'),(<'6 <-> 4, 5')

size=:#input
adjacent=: (size,size)$0

line_update"0 input

NB. returns a sorted list of cells adjacent from each of y, including y itself
reachable =: /:~@~.@(#&(i.size))@(+./@:{&adjacent)

echo $ reachable^:_ (,:0)
echo # ~. (reachable^:_)&.> <@,:"0(i.size) NB. boxes not strictly necessary, e.g.
                                           NB.     reachable^:_ ,:(i.size)
                                           NB. still works, but takes many many times longer
                                           NB. due to an excessive amount of 0s.
exit''
