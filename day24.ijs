#!/usr/bin/ijconsole

NB. from Phrases/Strings on the wiki
strsplit=:#@[ }.&.>[(E.<;.1]),

NB. x is index to remove, y is list
remove =: (~:i.@#@])#]

bridge_strength =: ((+/@:+:)-({.+{:))

input =: cutopen toJ 1!:1 < 'input24.txt'

pairs =: ".>>('/' strsplit&.> input)

NB. This function includes the "empty bridge"
build_bridges =: {{
    NB. x is remaining links, y is current chain
    result =. ,: < y
    for_i. I. ({: y) e."1 x do.
        NB. possible next links are at index = i
        pair =. {. i }. x
        if. ({: y) = ({. pair) do.
            new_chain =. y, ({: pair)
        else.
            new_chain =. y, ({. pair)
        end.
        result =. result , ((i remove x) build_bridges new_chain)
    end.
    result
}}

NB. building bridges takes ~4 s
bridges =: (pairs build_bridges ,: 0)

NB. part 1
echo >./ > bridge_strength&.> bridges

NB. part 2 -- there's probs a better way.
NB.                get  maximum length   = each length
longest_bridges =. (#~ (>./@:(>@(#&.>))) = (>@(#&.>))) bridges
echo >./ > bridge_strength&.> longest_bridges

exit''
