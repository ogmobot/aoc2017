#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

registers =: 0 2 $ _.

getvalue =: {{
    NB. finds current value of register y
    if. (<y) e. ({."1 registers) do.
        NB. finds LAST entry that matches - see setvalue
        > {: {: ((<y)=({."1 registers)) # registers
    else.
        0
    end.
}}

setvalue =: {{
    NB. sets register x to value y
    NB. (by appending an entry to the end of the register table)
    registers =: registers,(x;y)
}}

doline =: {{
    NB. line format is
    NB. 'gug dec 188 if zpw >= 8'
    NB. echo y
    words =. ' ' strsplit >y
    condreg =. getvalue > 4 { words
    condval =. ". > 6 { words
    NB. echo (> 4 { words),' is ',":condreg
    select. 5 { words
    case. <'==' do.
        do_it =. condreg = condval
    case. <'!=' do.
        do_it =. condreg ~: condval
    case. <,:'<' do.
        do_it =. condreg < condval
    case. <,:'>' do.
        do_it =. condreg > condval
    case. <'<=' do.
        do_it =. condreg <: condval
    case. <'>=' do.
        do_it =. condreg >: condval
    case. do.
        do_it =. 0
        echo 'error!'
        echo y
    end.
    if. do_it do.
        target =. > 0 { words
        delta  =. ". > 2 { words
        NB. echo target,' from ',":(getvalue target)
        if. (<'inc') = 1 { words do.
            target setvalue (getvalue target) + delta
        else.
            target setvalue (getvalue target) - delta
        end.
        NB. echo '  to ',":(getvalue target)
    end.
    _.
}}

input =: cutopen toJ 1!:1<'input08.txt'

doline"0 input
final_regs =: |: (] ,: getvalue&.>) ~. {."1 registers

echo >./"2 > {:"1 final_regs ,: registers

exit''
