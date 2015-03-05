pdf: clean build copy
	docker run -ti \
		-v $$PWD/out:/tmp/out \
		-v $$PWD/mallar:/tmp/mallar \
		-e MALL=$$MALL deadtree \
		make gen

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

gen:
	./kallelse.bash $$MALL
	pdftk $$(echo /tmp/out/*.pdf) cat output /tmp/out/$${MALL}-merged.pdf
	rm /tmp/out/$${MALL}_*

clean:
	rm -f out/*
