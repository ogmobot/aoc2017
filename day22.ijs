#!/usr/bin/ijconsole

NB. === part 1 ===
NB. infer current direction of ant
direction =: [:-/(2&{.)
NB. determine current value of coordinate y in list of coords x
colour =: (2&|)@([:+/=)

NB. current location is FIRST item in list, original location is LAST
step =: ] (,~) {. + direction * ({ & (0j_1 0j1)) @ (colour {.)
NB. point-free... so proud!

count_infections =: {{
    total =. 0
    for. i. y do.
        total =. total + (x colour {. x)
        x =. step x
    end.
    total
}}

NB. === part 2 ===
NB. hooo boy...
NB. 0 => clean, 1 => weakened, 2 => infected, 3 => flagged
colour2 =: (4&|)@([:+/=)

NB. note that we increment colour *before* deciding which direction to turn.
step2 =: ] (,~) {. + direction * ({ & (_1 0j1 1 0j_1)) @ (colour2 {.)

count_infections2 =: {{
    total =. 0
    for. i. y do.
        total =. total + (2 = (x colour2 {. x))
        x =. step2 x
    end.
    total
}}

NB. calling "colour" is too slow... let's try a different method.
count_infections_new =: {{
    result =. 0
    facing =. 0j1
    location =. 0
    grid_data =. 0 2 $ _. NB. whenever new cell is encountered, append it here
    index =. _.
    for_i. i. # x do.
        grid_data =. ((i { x), 2), grid_data
    end.
    grid_lookup =. (0{"1 grid_data)&i.
    for. i. y do.
        index =. grid_lookup location
        if. (# grid_data) = index do.
            grid_data =. (location, 0) , grid_data
            grid_lookup =. (0{"1 grid_data)&i.
            index =. grid_lookup location
        end.
        new_colour =. 4 | >: (1 { (index { grid_data))
        grid_data =. (location, new_colour) (index) } grid_data
        result =. result + (2 = new_colour)
        facing =. facing * (new_colour { (_1 0j1 1 0j_1))
        location =. location + facing
    end.
    result
}}

NB. set up an ant pointing up (i.e. current location 0, prev location -0j1)
new_ant =: 0 0j_1 0j_1 0j_1 0j_1

NB. centre of input is 0; therefore, top row is _((#input)-1 / 2)
file2coords =: {{
    result =: ''
    NB. for each row...
    for_i. i. #y do.
        NB. for each column...
        for_j. i. (# > (i { y)) do.
            if. '#' = j { > (i { y) do.
                result =: result , x $(j. (((<:#y)%2)-i)) + (j-((<:(# > (i { y)))%2))
            end.
        end.
    end.
    result
}}

input =: cutopen toJ 1!:1 < 'input22.txt'
setup =: new_ant, (1 file2coords input)
echo setup count_infections 10000
NB. setup =: new_ant, (2 file2coords input)
NB. echo setup count_infections2 10000000
NB. takes ~1h20m. Maybe look for cycles instead? (e.g. check pop every 1000 steps)
echo (1 file2coords input) count_infections_new 10000000

exit''
