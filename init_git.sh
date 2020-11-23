#!/bin/bash

echo "c'est parti c'est partouze pour initialiser un depot git !!!!!"
echo "il faut lancer ce script dans le repertoire link avec git." 
echo "Quel est le lien github/gittea/gitlab : "
read lien

echo "Combien d'exercice il y a t-il ? : "
read nb_exo


git init

touch README.md

for i in `seq 1 $nb_exo`
do
	mkdir exercice$i
	
	touch exercice$i/main.c
	echo "#include \"exercice$i.h\"
	
int main()
{
	return 0;
}" >> exercice$i/main.c

	touch exercice$i/exercice$i.c
	echo "#include \"exercice$i.h\"" >> exercice$i/exercice$i.c

	touch exercice$i/exercice$i.h
	echo "#ifndef __EXERCICE_H__
#define __EXERCICE_H__

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
		  
#endif" >> exercice$i/exercice$i.h

	touch exercice$i/Makefile
	echo "
CC = gcc
CFLAGS = -W -Wall -ansi -pedantic
LDFLAGS = -lm
EXEC = exercice$i #UNIQUE CHANGEMENT A FAIRE EN FONCTION DU NOM VOULU POUR L'EXECUTABLE
SRC = \$(wildcard *.c) #liste de nos fichiers sources générée automatiquement (faire attention aux dépendances de ces .c)
H = \$(wildcard *.h) #liste de nos fichiers .h générée automatiquement
OBJ = \$(SRC:.c=.o) #génération automatique de la liste des fichiers objets à partir de la liste des fichiers sources


all: \$(EXEC)

\$(EXEC): \$(OBJ)
	@\$(CC) -o \$@ \$^ \$(LDFLAGS)

%.o: \$(H) #déclaration des dépendances (ici tous les .o dépendent de tous les .h)

%.o: %.c #règle générique pour la construction d'un .o à partir d'un .c)
	@\$(CC) -o \$@ -c \$< \$(CFLAGS)


.PHONY: clean mrproper

clean:
	@rm -rf *.o

mrproper: clean
	@rm -rf \$(EXEC)" >> exercice$i/Makefile

done


git add *
git commit -m "first commit"
git branch -M master
git remote add origin $lien
git push -u origin master
