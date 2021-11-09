#!/usr/bin/ijconsole

NB. === matrix-handling functions ===

NB. split into 2x2 or 3x3 boxes.
split_mat =: {{
    if. 2|(#y) do.
        NB. odd dimensions and divisible by 3, so split into 3x3 boxes
        (|:&.>)@(<"2)@((((#y) % 3),3,3)&$)@,@|:@>@(_3&(<\)) y
    else.
        NB. even dimensions, so split into 2x2 boxes
        (|:&.>)@(<"2)@((((#y) % 2),2,2)&$)@,@|:@>@(_2&(<\)) y
    end.
}}

NB. join boxed matrices back into one.
NB. ugly, but at least it's point-free...
join_mats =: ((2&$)@%:@#@,@:>)$(,@((1 2)&|:)@:(>@(|:&.>)))

getsquares =: split_mat :. join_mats


NB. === text-processing functions ===

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

NB. convert '.##/###/##.' to (3 3 $ '.#######.'), for example
text2mat =: (]$~(2&$)@%:@#)@(]#~e.&'#.')

NB. arg is ['.##/###/##. => ..#./#.#./##../..##'], for example
NB. returns [from][to]
makerule =: (text2mat&.>)@({.,{:)@(' '&strsplit)


NB. === logic functions ===

NB. given a table x and a pattern y, return the corresponding pattern.
NB. check all eight rotations/flips of y.
lookup =: {{
    combos =. , (|:@|.&.>)^:(i.4) (];|.) y
    match  =. {.(e.&({."1 x)#]) combos
    > {: (({."1 x) i. match) { x
}}

step =: {{(x&lookup)&.>&.getsquares y}}

NB. === main program ===

input =: cutopen toJ 1!:1 < 'input21.txt'
rulebook =: > makerule&.> input

init =: 3 3 $ '.#...####'

NB. part 1
echo +/+/ '#' = (rulebook step^:5 init)
NB. part 2 (~25s)
echo +/+/ '#' = (rulebook step^:18 init)

exit''
