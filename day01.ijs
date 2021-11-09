#!/usr/bin/ijconsole

input=: ,"."0 >cutopen toJ 1!:1<'input01.txt'
NB. part 1
echo +/ ((2=/\ ],{.)#]) input
NB. part 2
echo +/ (,~(=/ ((-#input)%2)]\input))#input NB. could probs do this point-free too
exit''
