---
title: Meal-prep Automation  
author_profile: true  
tags: automation food preparation processing cooking nlp ai meal nutrition
---
My own struggles with eating well and cooking respectable meals combined with my need to break my teeth on process
capture has resulted in this project. Cooking recipes are a relatively low bar in terms of capture and codification as
they are short, contain a table of nouns (ingredients) and have limited context while trying to apply NLP. The lessons
learned from this project will help define the general problem of [Knowledge Capture](../knowledge/).

**Note: This is a live document and will be expanded upon as this project progresses**

# Tea, Earl Grey, Hot

<img src="picard.jpg" alt="Capt. Picard synthesizing tea" style="float: right" />
Those words are famous, and said right before a cup of hot tea was automatically prepared. While we are a long ways off 
from converting energy directly into complex matter in a household appliance, we can begin to address some of the problems 
that the replicator from Star Trek solved.

While taking business classes, my institution required us to identify pain points in the community and prototype
businesses to try to serve them. There was a strange recurrence of the same issues every semester that different groups
kept identifying. Three of them were food waste, food delivery, and good nutrition. Food waste is a troublesome problem
because when you go to assess the volume of food wasted by industry each week it is collectively enormous relative to an
individuals' perspective but relatively small compared to the size of the industry. The reason no one has ever found an
effective solution was because it nearly always boiled down to a logistics problem.

Students, busy professionals, and households requiring dual incomes have ever decreasing available time for tasks like
grocery shopping and preparing meals. The growing markets for grocery and restaurant delivery are the evidence of this.
People want to eat healthy but don't have the time to pursue elaborate meals and will opt for 'fast food' or prepackaged
meals. The effectiveness of these solutions all boil down to how well they can address the ever
pervasive [last mile](https://medium.com/the-stigo-blog/the-last-mile-the-term-the-problem-and-the-odd-solutions-28b6969d5af8)
problem. The cost of a product is largely determined by the number of hands that need to come into contact with it
before it arrives at the consumer.

So the question becomes: What is a solution that maximises food quality, variety, and freshness while minimising food
spoilage, cost, and human involvement before it can be consumed?

Like most problems, the answer generally involves automation. To maximise food freshness you need to minimise processing
of the food up until just before it is consumed. This means that you need to capture as much food preparation processes
as possible in a machine located as close to the consumer as possible. The alternative to this is exploring preservation
processes, allowing more factory processing long before products get to the customer. Food preservation has proven to
significantly reduce the nutritional value of food while also introducing chemical products that would not otherwise be
present.

## Problem - Human = Harder problem

<img src="robo-chef.jpg" alt="Robot makes pancakes" style="float: left" />
It is often frustrating to see engineers approach an automation problem by simply trying to replace the human in the
process. The end result is usually a poor approximation of a human, with a very narrow range of functionality, designed 
to replace the manipulation of the tools that were originally designed for a human. Trying to engineer a replacement human 
is a massive task to get right, and while advances in robotics and artificial intelligence are making it more viable, it 
is unnecessary and solves the wrong problem.

The other side of this is found in industrial automation. Brilliantly engineered machines and processing techniques that
do a single task very effectively, at scale. These solutions are effective because the engineers are handed a very
well-defined problem with strict constraints on the operating environment and input materials. In order to find an
equally effective general solution to food preparation, the problem needs to be equally well-defined. This means
capturing and understanding the whole problem, and all of its inputs and outputs.

## The secret to finding the right solution is by solving the right problem

Capturing the whole (and correct) problem involves cataloging every possible food recipe, and food product that we
intend to automate preparing. Conceivably you could just go one by one and build a machine that produces one recipe
each, but that is infeasible, and the end product would be enormously complex. The problem then needs to be reduced by
finding commonalities between all the processes and try to find reusable mechanisms to address as many as possible
without compromising quality of product.

For example, consider recipes describing the processes of mixing, blending, stirring, folding, kneading, whipping, (and
many more verbs that I am sure are exclusive to cooking). They are all effectively trying to homogenize a mixture of
substances. They are not necessarily immediately interchangeable though, especially within the context of a recipe. This
is where capture of the recipes and ingredients alone are not enough to successfully reproduce a recipe. Knowledge
capture of cooking professionals needs to occur, and that knowledge needs to be refined.

Molecular gastronomy is the field of study that seeks to better define culinary processes in terms of chemistry. The
work from this field can be used to further narrow the problems we are trying to solve with automation. Once we
understand the underlying principals of what a machine actually needs to accomplish we can begin to design it. Returning
to the mixing example, if the goal is simply to produce a homogenous mixture, you could use a conventional means of
doing so. This would involve dropping the materials in some sort of container, inserting some equivalent of a spatula,
and agitate the contents until it seeks a level of disorder via entropy. This approach depends on a random process, and
it would be difficult to control it in a way that would serve all the variations required by all the recipes. This would
be too close to trying to replace the human.

Machines are much better than humans at doing meticulous work quickly. This can be leveraged to produce a homogenous
mixture by placing each finite granule exactly where it needs to be. Imagine something like a 3D printer, placing each
ingredient layer by layer in the exact pattern desired for the mixture. This approach would allow infinite variability
of the mixtures and more readily serve the wide variety of needs of each recipe. The only limitation would be the
machines' ability to manipulate each ingredients' granule in the mixture at the scale required.

The second solution seems like it would be a better option, but it needs to be restated that that can't be known until
the problem is actually captured. It is very likely that a combination of the two methods, or even a third method would
be more appropriate. The point is that the problem needs to be fully defined first, and only then can unconventional
approaches be effectively hypothesised.

## Finding the right problem is a problem

Given the ambitious scale of this project, it demands some level of automation to just define the problem. Currently,
all recipes are stored in loosely structured natural language (English, French, etc.). Many of which are not even
encoded as text in a computer readable format (Books and images). Technologies need to be leveraged to automate much of
the task of codifying and restructuring the information in a format that allows computers to manipulate the data en
masse. This means pulling in [Natural Language Processing](https://en.wikipedia.org/wiki/Natural_language_processing)
, [Optical Character Recognition](https://en.wikipedia.org/wiki/Optical_character_recognition), and a variety of data
transformation, storage, and visualization systems.

Similarly, for knowledge capture to occur [ontologies](https://en.wikipedia.org/wiki/Ontology#Information_science) will
need to be used if not created. Luckily [existing projects](https://www.nature.com/articles/s41538-018-0032-6) have
already started this work. It is important to leverage as much existing work as possible, greater success can be found
by standing on the backs of giants. An ontology will give a structure for defining the processes in terms of the
underlying concepts, materials, their properties, and all the variations thereof. Collection of the processes into a
graph structure will allow the application of [graph theory](https://en.wikipedia.org/wiki/Graph_theory) to help reduce
the problem.
<img src="ontology.png" alt="Ontology" style="float: left" />

----

# Status

This project is currently waiting for time to be freed up from other ongoing projects.

## TODO

- Collect as many cooking recipes as possible in any format available
- Evaluate requirements for data ingestion and sanitization
- Preliminary data characterization and curation
- Secure funding for a molecular gastronomist and professional chef (same person?)
