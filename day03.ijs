#!/usr/bin/ijconsole

input =: 312051
NB. these formulas assume central integer is 0, not 1.
input =: <:input

find_z =: {{
    find_p=.<.@%:@>:@(4&*)          NB. "diameter" of box around the centre
    find_q=.]-(<.@(%&4)@*:@find_p)  NB. distance from corner of box
    p=.(find_p y)
    q=.(find_q y)
    (q*0j1^p)+( (<.((p+2)%4)) - (<.(((p+1)%4))*0j1) )*(0j1^(p-1))
}}

spiral =: find_z i. 1000000
rev_z =: spiral&i.

NB. the eight numbers surrounding y in the complex plane
neighbours =: (1j1 1j0 1j_1 0j1 0j_1 _1j1 _1j0 _1j_1)&+

part2 =: {{
    result =. 1 $ x:1
    index =. 1
    while. ({: result) < y do.
        z =. find_z index
        ns =. ((<&index)#]) (rev_z neighbours z)
        result =. result , (+/ ns { result)
        index =. >:index
    end.
    {: result
}}

NB. part 1
echo +/ | +. find_z input

echo x: part2 input

exit''
