#!/bin/bash

read -p 'quelles fichiers : ' nom
read -p 'nouveau nom : ' newnom
let "i=0"

for f in `ls | grep $nom`
do
	let "i=i+1"
	mv $f $newnom-$i
done
