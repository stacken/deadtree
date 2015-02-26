#!/bin/bash

if [ -z $1 ]; then
	echo "usage: $0 mallfil.tex"
	exit 1
fi

field() {
	echo $line | awk -F'|' "{print \$$1}"
}

mkdir -p out

IFS="
"
num=0
for line in $(./kallelse.pl | iconv -f iso8859-1 -t utf-8); do
	name=/tmp/out/${MALL}_${num}.tex
	cp /tmp/mallar/${MALL}.tex $name
	sed "s/NAMN/$(field 1)/" -i $name
	if [ ! -z $(field 2) ]; then
		sed "s/ADRESS/$(echo $line | awk -F'|' '{print "$3\n~~~~~~~~~ c/o " $2}')/" -i $name
	else
		sed "s/ADRESS/$(field 3)/" -i $name
	fi
	sed "s/POSTNUMMER/$(field 4)/" -i $name
	sed "s/ORT/$(field 5)/" -i $name

	echo "Generated $name"

	num=$(( $num + 1 ))
done
unset IFS

cd /tmp/out
for file in /tmp/out/*.tex; do
	latexmk -pdf -pdflatex=`which pdflatex` $file
done
