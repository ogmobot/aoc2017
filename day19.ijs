#!/usr/bin/ijconsole

iget =: (<@|.@+.@[){] NB. use complex number to index into array

step =: {{
    location  =. > 0 { y
    direction =. > 1 { y
    path      =. > 2 { y
    counter   =. > 3 { y
    grid      =. > 4 { y
    NB.echo 'location';location;'direction';direction;'path';path
    if. -. (location iget grid) e. ' -|+' do.
        NB. passing over a letter
        path =. path, (location iget grid)
    end.
    NB. input is padded, so no bounds-checking required
    if. ' ' = (location + direction) iget grid do.
        if. ' ' ~: (location + (direction * 0j1)) iget grid do.
            direction =. direction * 0j1
        elseif. ' ' ~: (location + (direction * 0j_1)) iget grid do.
            direction =. direction * 0j_1
        else.
            NB. end of the line!
            location =. location + direction
            counter =. <:counter
            direction =. 0
        end.
    end.
    (location + direction);direction;path;(>:counter);grid
}}

input =: > cutopen toJ 1!:1 < 'input19.txt'

echo ,. 2 3 { (step^:_) ((0 { input) i. '|'); 0j1; ''; 1; input

exit''
