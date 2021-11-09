#!/usr/bin/ijconsole

process=: {{
    index=. 0
    not_garbage=. 1
    layer=. 0
    score=. 0
    garbage_count=. 0
    while. index<#y do.
        select. index { y
        case. '!' do.
            index=. (>:index)
        case. '<' do.
            garbage_count=.garbage_count + (-.not_garbage)
            not_garbage=. 0
        case. '>' do.
            not_garbage=. 1
        case. '{' do.
            garbage_count=.garbage_count + (-.not_garbage)
            layer=. layer + not_garbage*1
        case. '}' do.
            garbage_count=.garbage_count + (-.not_garbage)
            score=. score + not_garbage*layer
            layer=. layer - not_garbage*1
        case. do.
            garbage_count=.garbage_count + (-.not_garbage)
        end.
        index=. >:index
    end.
    score,:garbage_count
}}

NB.test_string=: '{{<a!>},{<a!>},{<a!>},{<ab>}}'
NB.               {{<#  #####  #####  ######>}}

input=: , > cutopen toJ 1!:1 < 'input09.txt'
echo process input

exit''
