~Intro~
In what follows, I'll first dicuss each of the aforementioned tools, then I'll give a brief example of how one could use them.

### Git and Github
Perhaps the most ubiquitously used tools with regards to reproducibility are Git and Github.The importance of these tools stems from the very reason we use them in the first place: version control. Version control is just the task of keeping a software system that consists of many versions and configurations well organized. So how are Git and Github used to achieve this aim? And more importantly, where does Git end and Github start?

#### Git
There are many version control systems in existence, and Git is one of the most popular. The way it works is pretty simple. After installing Git to your local machine, you use Git to create a new project directory and then tell Git to remember the history of changes made within that directory.

Every time you add files, delete files, or make any change (no matter how big or small) to to this directory, you can tell Git to take a "snapshot" of the change. You repeat this process over and over, making changes and taking snapshots. The cool thing about Git is that it allows you to step back and forth whenever you need through all the snapshots in your project directory. This is version control.

What makes Git even more powerful is that it's a _distributed_ version control system.  This allows you to collaborate on a project with other people; i.e. anybody working on the project can make a change on their local machine and have the change appear in other collaborators project directory. As awesome as this is, it's still slightly inconvenient. After all, what if you were working on something only to have a collaborator update and completely change everything the next day, nullifying your work? Or what if you wanted to push a change but your collaborator didn't have their machine plugged in? Enter Github.

#### Github

Discuss Github





### Makefiles
A Makefile is a special type of executable file that organizes code compilation in a simple manner. Makefiles contain shell commands and are always named either "_Makefile_" or "_makefile_", depending on the system.
While inside the directory that contains the makefile, typing `make` into the shell will execute the commands inside the Makefile.

##### What's the point of a Makefile?
Typically, a Makefile is used to keep files up-to-date. Imagine that you have a very large file with many different files; changing a single file that has many dependencies on other files would require recompiling all of those dependent files. Obviously, this is very time-consuming. By bundling all of the files and their dependencies together, a Makefile allows us to do all of this in one command. What's more, `make` will keep track of previous updates of files, so running `make` again will only update files that contain changes.
Now that we've learned what a Makefile is, let's see an example of how to construct one.

#### Makefile Example
The structure of a Makefile is simple. It contains a list of **rules** that tell the system what to execute. These **rules** have the following structure:

```bash
target: dependencies 
  commands
```

Note that both dependencies and commands can be of arbitraty length. Dependencies are separated by whitespace, commands by new lines or via `;` (if multiple commands on a single line).


* `target`: This is the file we'd like to create. 
* `dependencies`: These are the dependencies dependent on the associated `target` file.
* `commands`: These commands determine how you create `target` from the associated `dependencies`. 

Below I list an explicit example for clarity. It may seem a bit overwhelming at first, but I'll work through it shortly thereafter.

Suppose we wanted to create the following file structure:
```
our_directory/
	README.md
	Makefile
	paper/
		sections/
		  report.md
```
We could structure a Makefile to create this as follows:

``` bash
.PHONY: all clean

all: paper README.md Makefile paper sections

paper: 
	mkdir paper

sections: paper   
	cd paper; mkdir sections
	echo init > paper/sections/report.md 

README.md:
  echo init > README.md
  
clean:
	rm -rf paper README.md
```

Now let's walk through what we just did.

The first two targets, `.PHONY` AND `all`, are special.Let's get all the special character you see out of the way:

* `all`: Specifies which _targets_ to be executed from `make` call. If you only want to execute specific targets, you can do `make <specific target name>`. If you want everything in the Makefile to run, you can just list each _target_, separated by a space, after `all:`
* `.PHONY`: This is a list of special commands that you used. Use this to account for the possible case where you have filenames in your directory that share special character names (e.g. if we had a file named `all` in our directory before running `make`, confusion could arise).
* `clean`: This tells you what bash commands to run if you run `make clean` in the command line. Conventionally, we use this to remove those elements that we just created, hence the commands `rm -rf paper READ.ME`, which will remove everything we _added_ to the directory via `make`.

Following this, we see the following rule:

```bash
paper: 
	mkdir paper
```
In this rule, our first target is paper, which has no dependencies. We give this target the command `mkdir paper`, which simply creates a directory called _paper_ in the directory holding our Makefile.

```bash
sections: paper   
	cd paper; mkdir sections
	echo init > paper/sections/report.md 
```
The above portion lists _sections_ as our target. We can see that the dependency is paper. This is listed as a dependency because we will reference this dependency in our commands. The commands are straightforward: change the directory into paper and create a new directory called sections. Then make a new file in that directory called _report.md_. Note that we had to reference the relative path of report.md _from the directory of the makefile_. This is because each new command line resets the directory to that which holds the makefile.

The `README.md` target case is parallel to the `paper` case.

The above example should be enough to get you started with makefiles. If you need any help, feel free to [email] me.

### Markdown

Markdown is a markup language with plain text formatting syntax. It is designed to be both easily read and easily converted to HTML (among other formats). This write-up itself was actually written in Markdown! (Right-click view source code to see what it looks like). Markdown is great because it allows for easy weaving between code, equations, and text, so it is often used in writing reports, blog posts, etc.. It can also be used in conjunction with other tools (one of which, pandoc, we'll discuss next) to produce very elegant outputs.

Markdown is actually very simple, so we'll learn via some brief examples.

We'll dicuss the following topics:

* **headers**
* **bold**
* **italics**
* **links**
* **inserting images**

 Although it was brief, I'm sure the above mini-tutorial for Markdown is enough to get you on your way to writing some posts in Markdown.
 
 #### Markdown Summary
 
 **Summary**: Markdown is an easy to use, easily converted plain-text language.
 
 **Uses**: To write research papers, blog posts, books; pretty much anything that uses text, code, math, or some combination thereof.


### Pandoc
Pandoc is a command-line tool that is used to convert markup files to different formats. Pandoc handles conversion to a multitude of documents. Possible input document types include (but are not limited to) markdown, reStructuredText, textile, HTML, DocBook, LaTeX, MediaWiki markup, TWiki markup, OPML, Emacs Org-Mode, Txt2Tags, Microsoft Word docx, LibreOffice ODT, EPUB, and Haddock markup.
Possible output document types include (but are not limited to) HTML formats (HTML5, XHTML), Ebooks, XML, docx, OPML, LaTeX, Markdown, DokuWiki markup, DocBook, PDF, and InDesign ICML.

There isn't much more pertinent informatino to reveal, so I'll display some examples of how to use pandoc via the command-line. Note that, depending on your system, certain dependencies may need to be installed for certain desired output types. 

Let's pretend that _report.md_ is a file currently located in your current working directory. To convert it to an html file named _report.html_ using pandoc is as simple as

```bash
pandoc -s report.md -o report.html
```

We can also convert it to pdf. *Note that you will need to have LaTeX installed for this to work.

```bash
pandoc report.md --latex-engine=xelatex -o report.pdf
```

In either example, the name of the final output is arbitrary. Just make sure that it has the desired extension type.

As pandoc is a command-line command, we can also used what we learned previously and create it in a Makefile!

```bash
report.pdf: report.md
  pandoc report.md --latex-engine=xelatex -o report.pdf
```

#### Pandoc Summary
**Summary** Pandoc is a universal document converter.

**Uses** Converting document types from one format to another. In the real world, this allows us to translate markdown files into elegant looking output.





