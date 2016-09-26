.PHONY: all clean

all: paper sections paper.html paper.md images .gitignore .README.md

paper: 
	mkdir $@ 

sections: paper sections   
	cd $<; mkdir $@
	echo init > paper/$@/00-abstract.md 
	echo init > paper/$@/01-introduction.md 
	echo init > paper/$@/02-discussion.md 
	echo init > paper/$@/03-conclusions.md 

paper.md: paper 
	cd $<; echo init > $@

paper.html: paper paper.md
	cd $<; pandoc -s paper.md -o $@

images:
	mkdir $@

.gitignore: 
	mkdir $@

.README.md:
	mkdir $@

clean:
	rm -rf images paper README.md


