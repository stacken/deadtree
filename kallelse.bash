#!/bin/bash

if [ -z $1 ]; then
	echo "usage: $0 mallfil"
	echo "If this was called from make, use 'MALL=mallfil' make ..."
	exit 1
fi

field() {
	echo $line | awk -F'|' "{print \$$1}"
}

render_co() {
	echo -n 'c\/o' $(field 2) '\\\\ '
}

render_adress() {
	echo -n $(field 1) '\\\\ '
	[ ! -z $(field 2) ] && render_co
	echo -n $(field 3) '\\\\ '
	echo -n $(field 4) $(field 5) '\\\\ '
	echo Sweden
}

mkdir -p out

IFS="
"
num=0
for line in $(./kallelse.pl | iconv -f iso8859-1 -t utf-8); do
	name=/tmp/out/${MALL}_${num}.tex
	cp /tmp/mallar/${MALL}.tex $name

	sed "s/FULLNAMEANDADRESS/$(render_adress)/" -i $name

	echo "Generated $name"

	num=$(( $num + 1 ))
done
unset IFS

cd /tmp/out
for file in /tmp/out/*.tex; do
	latexmk -pdf -pdflatex=`which pdflatex` $file
done
