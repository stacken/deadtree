run: clean build copy
		docker run -ti \
			-v $$PWD/out:/tmp/out \
			-v $$PWD/mallar:/tmp/mallar \
			-e MALL=$$MALL deadtree

build:
	docker build -t deadtree .

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
