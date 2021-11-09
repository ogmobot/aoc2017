#!/usr/bin/ijconsole
NB. set diagonal of a matrix to 0
stripdiags=:{{0(|:(i.#y),:(i.#y))}y}}
NB. find whole numbers in (%/~ line) that don't lie on diagonal
eachline=:{{+/ +/ stripdiags ((=<.)*]) (%/~) y}}

input=:".>cutopen toJ 1!:1<'input02.txt'
echo +/(>./-<./)|:input
echo +/ eachline"1 input
exit''
