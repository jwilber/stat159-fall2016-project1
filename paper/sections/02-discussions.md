
## Git and Github
Perhaps the most ubiquitously used tools with regards to reproducibility are Git and Github.The importance of these tools stems from the very reason we use them in the first place: version control. Version control is just the task of keeping a software system that consists of many versions and configurations well organized. So how are Git and Github used to achieve this aim? And more importantly, where does Git end and Github start?

#### Git

![](https://raw.githubusercontent.com/ucb-stat159/stat159-fall-2016/master/projects/proj01/images/git-logo.png)

There are many version control systems in existence, and Git is one of the most popular. The way it works is pretty simple. After installing Git to your local machine, you use Git to create a new project directory and then tell Git to remember the history of changes made within that directory.

Every time you add files, delete files, or make any change (no matter how big or small) to to this directory, you can tell Git to take a "snapshot" of the change. You repeat this process over and over, making changes and taking snapshots. The cool thing about Git is that it allows you to step back and forth whenever you need through all the snapshots in your project directory. This is version control.

What makes Git even more powerful is that it's a _distributed_ version control system.  This allows you to collaborate on a project with other people; i.e. anybody working on the project can make a change on their local machine and have the change appear in other collaborators project directory. As awesome as this is, it's still slightly inconvenient. After all, what if you were working on something only to have a collaborator update and completely change everything the next day, nullifying your work? Or what if you wanted to push a change but your collaborator didn't have their machine plugged in? Enter Github.

#### GitHub

![](https://raw.githubusercontent.com/ucb-stat159/stat159-fall-2016/master/projects/proj01/images/github-logo.png)

GitHub is a hosting service for Git repositories that includes many of its own features. You can think of each repository as its own working directory. What's more, unlike Git, which is a command-line tool, GitHub is has a Web-based graphical interface. This makes it easy to compare changes and administrate accounts, as well as find cool projects of interest. Combined with the snapshot commits from Git, GitHub provides a view into the life-cycle of any given software development project.

In what follows, I'll give a non-exhaustive tutorial on some Git commands. Once you've created a repo on Github and navigated into that associated directory, you can update your GitHub repo using the following commands _from your computers command line_.



##### `git init`

The git init command creates a new Git repository. 
* Can be used to convert an existing, unversioned project to a Git repository or initialize a new empty repository. 
* As most other Git commands are not available outside of an initialized repository, this will probably be the first coommand you use in a new project.

All you have to do is cd into your project folder and run git init, and you’ll have a fully functional Git repository.

```bash
cd project_directory
git init
```

##### `git clone`

* Copies an existing Git repository; a "working copy" with its own history that manages its own files and is a completely isolated environment from the original repository.

*Cloning automatically creates a remote connection called origin pointing back to the original repository. This makes it very easy to interact with a central repository.

*Like `git init`, you generally only clone a repo once. After cloning, all version control operations and collaborations are managed through their local repository.

```bash
git clone <repo> # clones repo to where ever you are
git clone <repo> <dir>  #clones the repo to <dir>
# cd into repo
# modify project
```

##### `git add`

* Adds a change in the working directory to the staging area. This is the *snapshot* Git takes. Signifies to Git that you want to include updates to a particular file in the next commit but doesn't affect the repository until you run `git commit`.

Example uses:

* `git add <file>`: stage all changes in <file> for commit
* `git add <dir>`: stage all changes in <dir> for commit
* `git add -p`: Begin an interactive staging session that lets you choose portions of a file to add to the next commit. 

##### `git commit`

* Commits the added file to the repository. This records the committed version of a project into the repository's history.
* After running this command, you can then use `git push` to update whatever repository you're currently working on. 
* This command is typically run as `git commit m- "<message>"`, where <message> is a detailed, user-input message regarding the committed changes.

##### Git Workflow overview

Developing a project revolves around the basic edit/stage/commit pattern. First, you edit your files in the working directory. Then, when you’re ready to save a copy of the current project state, you stage changes with `git add`. Afterward, you commit it to the project history with `git commit`. Finally, when you're ready to update the non-local repository on GitHub, use `git push`.

##### Other useful Git Commands

* `git status`: Displays the current files in the directory and whether or not they are staged for committing.
* `git log`: shows information regarding the committed project history.
Displays committed snapshots. It lets you list the project history, filter it, and search for specific changes. 
* `git pull`: Pulls any changes from the repository you're working on and stores them to your local working directory.

##### Git Summary
The whole idea behind any version control system is to store “safe” copies of a project so that you never have to worry about irreparably breaking your code base. Git allows us to do this in a very effective manner. GitHub allows us to easily collaborate with others and provides a user-friendly interface that also allows us to work on multiple projects in an organized manner.

***

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

The above example should be enough to get you started with makefiles. If you need any help, resources like Google and stackoverflow are your best friend.

***

## Markdown

![](https://raw.githubusercontent.com/ucb-stat159/stat159-fall-2016/master/projects/proj01/images/markdown-logo.png)

Markdown is a markup language with plain text formatting syntax. It is designed to be both easily read and easily converted to HTML (among other formats). This write-up itself was actually written in Markdown! (Right-click view source code to see what it looks like). Markdown is great because it allows for easy weaving between code, equations, and text, so it is often used in writing reports, blog posts, etc.. It can also be used in conjunction with other tools (one of which, pandoc, we'll discuss next) to produce very elegant outputs.

Markdown is actually very simple, so we'll learn via some brief examples.

We'll dicuss the following topics:

#### Headers
  * To create a header, preface text with the 1-6 `#` characters; the smaller the number of `#` characters, the bigger the header.
  * For example, the above **Headers** title was written as `#### Headers`, while the **Markdown** title was written as `##Markdown`.
  
#### Bold 
  * To make a character or statement bold, simply wrap it around two `*` or `_` symbols on each side. 
  * For example, `**this is a bold sentence**` will output **this is a bold sentence**. We could have also written it as `__this is a bold sentence__`.
  
#### Italics
  * To make a character or statement italicied, simply wrap it with a single `*` or `_`. 
  * For example, `_Italicied_` will output _Italicized_.
  
#### Inline Links
  * To add a link, simple preclude a url inside `[](url)`. You can also make it reference text like so: `[this is text to click on](myurl)`.
  * For example, this  `[my github](github.com/jwilber)` will output a link to my github like so: [my github](github.com/jwilber)
  
#### Inline Images
  * To add an inline image, follow the following template `![alt text](url of image link or relative path to image "Optional Title")`
  * For example, this linke `[llama](http://cdn.quotesgram.com/small/9/68/585998811-aef421082816b8b5fb59218374fe0a05.jpg) "Hipster LLama")` will display the following beautiful llama: ![llama](http://cdn.quotesgram.com/small/9/68/585998811-aef421082816b8b5fb59218374fe0a05.jpg))
  

 Although it was brief, I'm sure the above mini-tutorial for Markdown is enough to get you on your way to writing some posts in Markdown. There are many other sources available online to get you started. Learning markdown is very easy and will go lengths in helping you produce beautiful, readable outputs.
 

 
***

## Pandoc

![](https://raw.githubusercontent.com/ucb-stat159/stat159-fall-2016/master/projects/proj01/images/pandoc-logo.png)

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
Thus, we can see the ubiqutous benefit having Pandoc: It easily converts document type from one format to another which, in the real world, facilitates the translation from markdown files into elegant looking output. 

***

### This paper

This paper used the above tools in the following ways:

* **Git**: Used to keep track and manage changes
* **GitHub**: Used to create the project repository as well as manage changes via Git.
* **MakeFile**: Used as a structure generator for the template of my GitHub repository.
* **Markdown**: Used to write every part of what you're seeing right now.
* **Panddoc**: Used to convert this (and the other markdown files) into a pretty html file (stored on GitHub).


