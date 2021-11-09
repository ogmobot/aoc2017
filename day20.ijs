#!/usr/bin/ijconsole

NB. translate digit => digit, comma => comma, dash => _, all else => space
cleanline =: ({&'0123456789,_ ')@('0123456789,-'&i.)

input =: cutopen toJ 1!:1 < 'input20.txt'

NB. shape of data is (1000 9) == px py pz vx vy vz ax ay az
NB.                               0  1  2  3  4  5  6  7  8
data =: (".@cleanline@>) input

simulate_particle =: {{
    NB. update velocity
    y =. ((3 4 5{y) + (6 7 8{y)) (3 4 5)}y
    NB. update position
    ((0 1 2{y) + (3 4 5{y)) (0 1 2)}y
}}

simulate_all =: {{
    y =. /:~ simulate_particle"1 y
    NB. remove all particles whose position's counts aren't 1 (i.e. duplicates exist)
    y #~ (=&1) +/"1 =/~ <"1 (0 1 2 {"1 y)
}}

NB. part 1: find index with greatest manhattan-magnitude of ax ay az;
NB.         there are three. By inspection, the second of these has
NB.         a velocity most opposed to its acceleration; so it stays closest.
NB. echo 0 1 2 { data /: (+/@:|)"1 (6 7 8 {"1 data)
echo 1 { /: (+/@:|)"1 (6 7 8 {"1 data)

NB. part 2
NB. As it turns out, all collisions happen within 40 steps
late_state =: (simulate_all^:40) data
echo # late_state

exit''
