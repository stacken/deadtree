run: clean build copy
		mkdir -p out
		docker run -ti \
			-v $$PWD/out:/tmp/out \
			-v $$PWD/mallar:/tmp/mallar \
			-e MALL=$$MALL deadtree

build:
	docker build -t deadtree .

copy:
	rm -f out/finger.txt
	cp /afs/stacken.kth.se/home/stacken/Private/finger.txt out/finger.txt

gen:
	./kallelse.bash $$MALL

clean:
	rm -f out/*
