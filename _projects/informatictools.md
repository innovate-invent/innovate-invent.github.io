---
title: Informatic tools  
author_profile: true  
tags: data science pipeline workflow visualization informatics tools cloud serverless
---
Professionally I am a data scientist, at least that is what they told me when I was hired. I find myself spending most
of my time simply trying to get the data, software, and compute resource in the same place at the same time and run it
all in a manner that respects scientific and [InfoSec](https://en.wikipedia.org/wiki/Information_security) principals.
This project was born from my frustration with the mess of data science tools that largely come from academic
institutions. I wanted a system that uses established standards, doesn't try to reinvent anything, and isn't tied to any
one infrastructure. I also needed a project that would introduce me to some challenges of capturing processes and help
identify and define the problem of the [Knowledge Capture](../knowledge/) project. Data analysis and computer processes
in general are very well-structured, defined, and already codified in a way that computers understand. Unlike
the [Meal-prep automation](autokitchen/) project, this a good start to focus on the more abstract challenges of
describing processes.

**Note: This is a live document and will be expanded upon as this project progresses**

# Welcome to my hell

This project outline is going to be very difficult to not seem ranty as it addresses a number of my daily professional
pains. The exciting part of data science is that it is still very new and much like the wild west. The horrible part of
data science is that it is very new and much like the wild west. Sometimes I wonder if Polio would be better than
dealing with some issues I have to address on a daily basis. To get you up to speed, understand that there are three
main aspects to working with data:

### The data (duh)
is problematic because there are a million different formats, with varying levels of structure, and
loosely follow some poorly if not ad hoc defined schemas. This means that if you want to run a program on a piece of
data, you have to interconvert it between different variants of the same format. This often turns into manually editing
the file. Many of the formats are text based and encode data as text, this gives rise to many free-form variants,
including using different text cases (upper vs lower) and value identifiers that are synonyms of each other.

Other than the data document itself there are storage requirements that have to be met. Data security is vital if you
are ever working with human data, with legal implications if you mess up. This means that moving data from one compute
resource to another can be tedious, not because accessing them is difficult but because you have to go through a lot of
hoops to figure out if you are allowed to store that data there. The size of the data is another issue, often you are
working with hundreds of gigabytes, possibly spread over millions of little files. You can quickly slam into a poorly
documented resource quota midway through an analysis only to have to pack up and move the data to another system to get
around the quota.

Access patterns of the data also need to be considered, and you need to place the data in a location that the underlying
hardware can support. Data that is read-only, read-once has very different technical requirements than data that is
being written to millions of times per second. It is usually a process of trial and error to figure out how any tool
accesses the data. Meaning you have to start processing the data, wait for the system to explode, move the data to a
more appropriate location, rinse, repeat.

### The tools 
are the largest part of the problem. They are often written by students with little to none of the
practices you might expect of a professional programmer. Documentation is usually sparse if it exists, and the code is
usually written by someone who wanted to get creative with code structure. Many of the tools are also decades old, and
still in use because the algorithm they implement is conceptually very useful despite the implementation. Software that
has been optimised generally optimises for the wrong things and put huge demands on a single compute node. The chosen
language that the software was written in is often completely inappropriate for its purpose, and there is an
unmanageable variety of dependencies each language ecosystem pulls in. Some software even has undeclared dependencies
that require low level hacking to determine why it works on some systems and not others.

### The infrastructure 
is less inherently a problem and more just dealing with the variety of environments and
restrictions that each one places.

### The pipeline
yes I can count, ..... TODO

