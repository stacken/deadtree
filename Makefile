pdf: clean build copy
	docker run -ti \
		-v $$PWD/out:/tmp/out \
		-v $$PWD/mallar:/tmp/mallar \
		-e MALL=$$MALL deadtree \
		make gen-pdf

html: build
	docker run -ti \
		-v $$PWD/out:/tmp/out \
		-v $$PWD/mallar:/tmp/mallar \
		-e MALL=$$MALL deadtree \
		make gen-html

plain: html
	docker run -ti \
		-v $$PWD/out:/tmp/out \
		-v $$PWD/mallar:/tmp/mallar \
		-e MALL=$$MALL deadtree \
		make gen-plain

build:
	docker build -t deadtree .

debug:
	docker run -ti \
		-v $$PWD/out:/tmp/out \
		-v $$PWD/mallar:/tmp/mallar \
		-e MALL=$$MALL deadtree \
		bash

copy:
	mkdir -p out
	rm -f out/finger.txt
	cp /afs/stacken.kth.se/home/stacken/Private/finger.txt out/finger.txt

gen-pdf:
	./kallelse.bash $$MALL
	pdftk $$(echo /tmp/out/*.pdf) cat output /tmp/out/$${MALL}-merged.pdf
	rm /tmp/out/$${MALL}_*

gen-html:
	htlatex /tmp/mallar/$${MALL}.tex
	cp $${MALL}.html out
	cp $${MALL}.css out

gen-plain:
	links -dump -codepage UTF-8 out/$${MALL}.html > out/$${MALL}.txt
	sed -i '/FULLNAMEANDADRESS/d' out/$${MALL}.txt

clean:
	rm -f out/*
