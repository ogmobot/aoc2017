#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

NB. x is index to remove, y is list
remove =: (~:i.@#@])#]

to_num =: 'ABCDEF'&i.

input =: cutopen toJ 1!:1 < 'input25.txt' NB. no blank lines

NB. Mercifully, this file is relatively easy to parse
build_turing_machine =: {{
    y =. }:&.> y NB. remove trailing punctuation
    begin_state =. {. to_num > {: (' ' strsplit > (0 { y))
    remaining_steps =. ". > (5 { (' ' strsplit > (1 { y)))
    rules =. 6 6 $ 0 NB. six states by six data per state (see below)
    for_i. 2+9*i.6 do.
        NB. Each rule is 6 values:
        NB. (write if 0, move if 0, next if 0), (write if 1, move if 1, next if 1)
        NB. move is _1 for left, 1 for right
        which_rule =. {. to_num > {: (' ' strsplit > i { y)
        write_0 =. ". > {: (' ' strsplit > (i+2) { y)
        move_0 =. ('l'= {.@>@{:(' ' strsplit > (i+3) { y)) { (1 _1)
        next_0 =. {. to_num > {: (' ' strsplit > ((i+4) { y))
        write_1 =. ". > {: (' ' strsplit > (i+6) { y)
        move_1 =. ('l'= {.@>@{:(' ' strsplit > (i+7) { y)) { (1 _1)
        next_1 =. {. to_num > {: (' ' strsplit > ((i+8) { y))
        rules =. (write_0, move_0, next_0, write_1, move_1, next_1) which_rule} rules
    end.
    NB. last fields are cursor and location of 1s
    begin_state ; remaining_steps ; rules ; 0 ; (0 $ _.)
}}

turing_step =: {{
    current_state =.   > 0 { y
    remaining_steps =. > 1 { y
    rules =.           > 2 { y
    cursor =.          > 3 { y
    ones =.            > 4 { y

    rule =. (current_state { rules) {~ (0 1 2 ,: 3 4 5) {~ (cursor e. ones)
    if. 0 { rule do.
        NB. write a 1
        ones =. ~. (ones, cursor)
    else.
        NB. write a 0
        ones =. (#~~:&cursor) ones
    end.
    cursor =. cursor + 1 { rule
    current_state =. 2 { rule

    current_state ; (<:remaining_steps) ; rules ; cursor ; ones
}}

t =: build_turing_machine input
n =: > 1 { t

NB. takes ~270s
final_t =: (turing_step^:n) t

echo # (> 4 { final_t)

exit''
