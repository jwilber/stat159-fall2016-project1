all: paper sections paper.html paper.md images .gitignore .README.md

paper: 
	mkdir paper 

sections: paper sections   
	cd paper; mkdir sections
	echo init > paper/sections/00-abstract.md 
	echo init > paper/sections/01-introduction.md 
	echo init > paper/sections/02-discussion.md 
	echo init > paper/sections/03-conclusions.md 

paper.md: paper paper.md
	cd paper; echo init > paper.md 

paper.html: paper paper.md
	cd paper; pandoc -s paper.md -o paper.html

images:
	mkdir images

.gitignore: 
	mkdir .gitignore

.README.md:
	mkdir README.md



