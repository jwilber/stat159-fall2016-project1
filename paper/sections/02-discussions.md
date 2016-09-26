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

Below I list an explicit example for clarity.

Suppose we wanted to create the following file structure:
```
our_directory/
	README.md
	Makefile
	paper/
		sections/
		  report.md
		  report.html
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

report.md: paper 
	cd $<; echo init > $@

report.html: paper/sections report.md
	cd papers/sections; pandoc -s report.md -o report.html


clean:
	rm -rf paper README.md
```


sections: paper sections   
	cd $<; mkdir $@
	echo init > paper/$@/report.md 



Some special commands for Makefiles are as follows:

`all`: Specifies which _targets_ to be executed from `make` call. If you only want to execute specific targets, you can do `make <specific target name>`.
`clean`:
`.PHONY`: list of special commands that you used. Use this to account for the possible case where you have filenames in your directory that share special character names (i.e. if you used `all` or `clean`.)













