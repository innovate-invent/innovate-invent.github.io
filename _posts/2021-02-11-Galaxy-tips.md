---
title: Tips and tricks for the Galaxy  
excerpt: Some interesting concepts and techniques within Galaxy pipelines  
tags: galaxy project pipeline workflow tips tricks control flow  
published: false
---

TODO

## Intro to Galaxy

[The Galaxy Project](https://galaxyproject.org/) aims to bring together the various disparate data science resources and
provide a means for public compute resources to host them. Given the sheer variety of infrastructures designs and data
storage mechanisms, this was no small task. At its heart it provides an abstraction layer for various data processing
and analysis tools. It uses this abstraction to allow chaining these tools into data pipelines (it refers to them as "
workflows"). There are a number of other solutions available to do this task such
as [SnakeMake](https://snakemake.readthedocs.io/en/stable/), [NextFlow](https://www.nextflow.io/)
, [CWL](https://www.commonwl.org/), [WDL](https://openwdl.org/), and a smattering of others.

Galaxy is distinct because it provides a daemon service to allow the resources to be accessed over the web. It also
combines this with data storage, access control, and visualization. One of the most important distinguishing features in
my mind is that Galaxy stores its pipelines as a graph data structure. This is important because you invest tremendous
amounts of time and money building these pipelines. You want to ensure that that investment is secure against changes in
the software over time. Storing as a data structure means that the pipeline can readily be queried and transformed by
any software that can read that structure format (JSON/YAML). The other mentioned solutions store their pipeline
descriptions as code. This means that you would have to either write a complex syntax parser to try to transform the
pipeline to another solutions format, or manually reimplement the pipeline. Manually reimplementing the pipeline is
always going to be plagued with mistakes and failure to capture subtle or implicit functionality.

If you would like to play with Galaxy, one of a number of freely available instances is https://usegalaxy.org/

## Into to collections

One of the most potent features of Galaxies pipeline functionality is its concept of a dataset collection (list). The
concept of a list of datasets is not particularly revolutionary, but Galaxies behavior when working with them is. The
mundane use is for tools to require a collection of datasets to operate on. This requirement is specified in the tools
wrapper and Galaxy ensures that the tool gets what it wants. Galaxy extends this to allow describing collections of
pairs of datasets (list:pair) which is tremendously important when a tool wants to operate on pairs of related datasets
such as what is output from double ended DNA sequencing. Collections can be extended even further to allow for
collections of collections, which allows you to maintain subgroups of collections within a collection (list:list or
list:list:list). It is important to know that collections are ordered, and operations are available to sort or modify
that order. Most [Galaxy instances](https://usegalaxy.org/) provide these operations under the "Collection Operations"
section of its tool panel. It is beneficial to become familiar with all of them while setting out to create a pipeline.

The real magic is when you try to pass a collection of various types to a tool that is not expecting a collection, or
collection of collections. This magic is referred to as "mapping over" a collection to a tool. If you pass a collection
to a tool that is expecting a single dataset, Galaxy will map over that tool repeating its execution for each collection
element. If a tool is mapped over a collection and normally produces a single dataset output, it will produce a
collection of outputs. The collection of outputs will be ordered with respect to the order of the input collection.

## Advanced mapping

This behavior of mapping over collections goes even further, to where a tool that is expecting a collection can be
mapped over by passing it a collection of collections (list:list). You can expect similar behavior when working with a
collection of collections of pairs (list:list:pair).

Things get fascinating when you consider how Galaxy behaves when a tool has multiple inputs, and it is being mapped
over. If one input is being mapped over, and another is a single dataset, each invocation will receive that single
dataset. If both inputs are being mapped over, it is important to ensure that the collections are of equal size or
Galaxy will throw errors. The two collections will then be
"zipped" ([similar to python zip](https://data-flair.training/blogs/python-zip-function/)) together, where each tool
invocation will receive the nth dataset (or subcollection) from each collection.

One of the most powerful properties of mapping over appears when you consider the simplest collection, the empty
collection. What happens when a tool is mapped over an empty collection? It is never executed and results in another
empty collection. Keep this in mind as you read on.

## GNU Awk in all its glory

Awk, the predecessor of GNU Awk, was originally written in 1977 at AT&T Bell Laboratories. GNU Awk (or gawk) is a
powerful little rule based text processing tool. It has a complete scripting language built in that can do everything
from generating, reformatting, or filtering text to fully interactive applications than can make network requests.
See [GNU AWK Users Guide](https://www.gnu.org/software/gawk/manual/gawk.html) for more information on the software and
its applications.

Unlike larger scripting languages such as Python, gawk remains simple enough that it can be
effectively [sandboxed](https://en.wikipedia.org/wiki/Sandbox_(computer_security)). This allows it to be provided as a
public resource for use in data analysis pipelines. I spent some time ensuring that I could not find a way to break out
of the sandbox, and despite its age, actually managed to find two significant vulnerabilities that could provide attack
vectors to its host system. Arnold Robbins, one of the authors of gawk, was quick to respond to my reports of these
issues and since version !!TODO!! I can now confidently recommend this software. See
the [--sandbox](https://www.gnu.org/software/gawk/manual/html_node/Options.html) argument for more information.

<img src="/assets/posts/2021-02-23-Galaxy-workflow-flow-control/awkscript.png" alt="Galaxy GNU Awk wrapper" style="float: left"/>

Since then, I have created the [Galaxy AWKScript wrapper](https://toolshed.g2.bx.psu.edu/view/brinkmanlab/awkscript/).
The wrapper forwards a number of very useful bits of information from the related Galaxy objects. Within the gawk
environment a variable 'tool_input' will be set to the index of the wrapper inputs, in order. You can combine this with
[ARGIND](https://www.gnu.org/software/gawk/manual/html_node/Auto_002dset.html) to determine which file you are currently
operating on and its position in any possible input collection. A variable 'tool_input_id' is also set specifying the
current inputs dataset name or collection id. Beware that ARGIND will increment 3 between inputs as one is consumed
setting tool_input and another setting tool_input_id. The wrapper inputs provide the ability to specify if they accept
single inputs or if they accept collections of inputs. This is very useful when trying to get a specific collection
mapping behavior.

The environment inputs allow you to generalise your scripts, specifying constants with the tool invocation, or allow
attaching simple workflow parameter inputs. Environment variables are accessible
via [ENVIRON](https://www.gnu.org/software/gawk/manual/gawk.html#index-environment-variables_002c-in-ENVIRON-array).

This tool allows you to embed scripting logic within a workflow that is aware of the various properties of the workflow
data. That data can be leveraged along with collection operation tools to provide a whole new level of functionality of
Galaxy workflows.

## Flow control

Galaxy does not (and rightfully so) provide an embedded scripting language or flow control. Remember, its pipelines are
nothing more than graph data structures. This can be frustrating when trying to create pipelines that change their
behavior based on input or intermediate data values. Combining my gawk tool wrapper, select collection operation tools,
and "mapping over" functionality provides a robust mechanism for a variety of flow control operations.

This workflow demonstrates the simplest form of flow control, a conditional:
<img src="/assets/posts/2021-02-23-Galaxy-workflow-flow-control/workflow.png" alt="Galaxy workflow demonstrating basic control flow" />



