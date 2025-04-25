---
title: Workflows, Pipelines, and Dataflows. OH MY!
excerpt: A tumble down the cliff of academic software and standards
published: false
tags: [workflow, pipeline, dataflow, CWL, galaxy, job, runner]
at_url: at://did:plc:gdfkbwgnydyn4xgea7e7e6ht/app.bsky.feed.post/
---

Like all good speeches, I would like to begin by quoting a definition:

__Pipeline__
>A pipeline is a series of processes, usually linear, which filter or transform data. The processes are generally assumed to be running concurrently. The data flow diagram of a pipeline does not normally branch or loop. The first process takes raw data as input, does something to it, then sends its results to the second process, and so on, eventually ending with the final result being produced by the last process in the pipeline. Pipelines are normally quick, with a flow taking seconds to hours for end-to-end processing of a single set of data.
>
>Examples of pipelines in the real world include chaining two or more processes together on the command line using the '|' (pipe) symbol, with results in stdout or redirected to a file, or a simple software build process driven by 'make'.

__Workflow__
>A workflow is a set of processes, usually non-linear, often human rather than machine, which filter or transform data, often triggering external events. The processes are not assumed to be running concurrently. The data flow diagram of a pipeline can branch or loop. There may be no clearly defined "first" process -- data may enter the workflow from multiple sources. Any process may take raw data as input, do something to it, then send its results to another process. There may be no single "final result" from a single process; rather, multiple processes might deliver results to multiple recipients. Workflows can be complex and long-lived; a single flow may take days, months, or even years to execute.
>
>Examples of workflows in the real world include document, bug, or order processing, or iterative processing of very large data sets, particularly if humans are in the loop.

__Mixing of terms__
>These terms have become mixed in recent years, in part because pipelines can be implemented as a very simple subset of workflows. In previous decades, workflow software was large, complex, commercial, and involved high licensing fees, while pipelines were a thing you did on the fly or in a shell script. The terminology has become more blurred as simpler "workflow" software packages have emerged; some of these are really just complicated versions of distributed 'make', and don't support humans in the loop. They really should have been called "data flow" rather than workflow packages. Likewise, there have been more efforts to support branching, looping, and suspended flows in "pipeline" libraries for various languages, and we've seen more pipelines spread over multiple machines, with data transport via HTTP, other TCP protocols, or shared networked filesystems.

-- [stevegt 2016](https://www.biostars.org/p/17696/#203354)

Steve succinctly summarised something that had been bothering me when talking about workflows and [CWL](https://github.com/common-workflow-language/common-workflow-language). "Workflow" is largely a misnomer in these contexts, a workflow manager is more abstract and generally found in the buisness world as a BPM such as [YAWL](http://www.yawlfoundation.org/).

A year ago I did a survey of "Workflow" managers, concluding [Galaxy](https://galaxyproject.org/) a clear winner. It managed data, data formats, [data provenance](https://en.wikipedia.org/wiki/Data_lineage#Data_Provenance), tool dependencies, job runners, access control for shared environments, and bundled it all up into a GUI.

Since then my use of Galaxy has had me developing against nearly every aspect of its codebase. 
