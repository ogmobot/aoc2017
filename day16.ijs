#!/usr/bin/ijconsole

initstr=:'abcdefghijklmnop'

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

dance=: {{
    for_i. i.#y do.
        command =. >i{y
        select. 0{command
        case. 's' do.
            x=.x|.~-".}.command
        case. 'x' do.
            slash=.command i. '/'
            slash {. command
            a =. ". }. slash {. command
            b =. ". (>:slash) }. command
            x =. ((b{x),a{x) (a,b)} x
        case. 'p' do.
            slash=.command i. '/'
            a =. x i. (}. slash {. command)
            b =. x i. (>:slash) }. command
            x =. ((b{x),a{x) (a,b)} x
        end.
    end.
    x
}}

NB. input=: 's1';'x3/4';'pe/b'
input=: ',' strsplit , > cutopen toJ 1!:1 < 'input16.txt'

echo initstr dance input

NB. noob way of doing part 2 -- but only 1k iterations takes ~25 seconds.
NB. echo (dance&input)^:one_billion 'abcdefghijklmnop'

cycle_length=: <:#(,(dance&input)@{:)^:({.(+./@:~:)({:@}.))^:_ ,:initstr

echo (dance&input)^:(cycle_length | 1000000000) initstr

exit''
