---
permalink: /projects/
title: Projects
---

Long term projects
---

[Knowledge Capture](knowledge/)
----
Consider the variety of ways humanity stores its knowledge: the medium, structure, language, and means of access. With
the extreme variety comes silos and disconnects. It is likely we know more than we think we do, the information is just
ininaccessible to the ones who need it. I want to explore and capture 'knowledge' in the most abstract sense and make it
generally accessible, to both humans and computers.

[Meal-prep automation](autokitchen/)
----
Increasing pressure on peoples time, nutrition, and food waste are requiring higher levels of automation. I want to
capture food preparation processes and use them to guide the design of a fully automated kitchen. This kitchen would be
able to prepare any known recipe. Lessons learned from this project will feed back into
the [Knowledge Capture](knowledge/) project.

[Unified data science](informatictools/)
----
Data science is rife with many disparate resources, data repositories, tools, and standards. I want to unify the various
resources associated with data science. This involves fully capturing the tools and data in a way that respects the
practical implications of the supporting infrastructure. Lessons learned from this project will feed back into
the [Knowledge Capture](knowledge/) project.

[Sign language assist](eyeth/)
----
"Blindness cuts us from things, but deafness cuts us off from people." -Helen Keller  
Coping with hearing impairment comes with numerous challenges and depending on the available support systems can lead to
lifelong troubles functioning in society. I have identified some readily available technologies that when combined will
bridge the education and communication gap between these peoples and their communities.

Software
---

[Javascript DNS client](https://github.com/innovate-invent/dns)
----
Dependency free, browser compatible, NodeJS dns library replacement. Implements RFC8484 and RFC1035. Supports most DNS
over HTTPS servers. Why would you want to make DNS requests from a browser? DNS has numerous functions other than
mapping domain names to IP addresses. SRV and TXT records offer the ability to do service discovery and distribute
information such as public keys.

<!--
[SocProx](https://github.com/innovate-invent/socprox)
----
-->

[Custom Linux Distro]() (To be named)
----
I have been exclusively using Linux for well over 15 years now, bouncing from various popular distros like Ubuntu, Arch,
and Mint. This experience has come to a critical mass in my understanding of the Linux operating system and its
ecosystem. This project is a vehicle to deep dive into the various components, discovering and closing any gaps I may
have in my knowledge on the subject. Through the years I have built up a wishlist of features to help simplify managing
and maintaining my Linux deployments, and intend to realise this list in a novel approach.


Projects backburnered due to time, resource, or demand constraints
---

[Bluetooth surround sound](btsurround/)
----
I wanted a quick and portable way to deploy positional audio into a space. This project explores using Bluetooth
speakers and PulseAudio to accomplish this.

[ESP8266](esp8266/)
----
The ESP8266 is a very cool little WIFI enabled uC and the market is flooded with cheap modules that have been built
around it. I am looking at various solutions that can be built around it to make renter friendly smart home devices.

[bampy](https://github.com/innovate-invent/bampy)
----
Most python libraries that allow reading and writing HTS data (sam/bam) either link against HTSLib externally or are
limited in functionality. I needed a python native implementation of HTSLib to allow compatibility with the Numba
project. This will allow for much faster performing python code and even GPU accelerated algorithms.

[configutator](https://github.com/innovate-invent/configutator)
----
I was not satisfied with the command line argument parsers available for python and wrote my own. It was built to
minimise the amount of code needed while maximising flexibility. This is intended for applications where the command
line arguments are numerous.

blind winder
----
Ever see those blinds that automatically go up and down in smart homes? Well I needed a more renter friendly solution.
There are some good ones on the market but they are over $100 per window. I know I can build it cheaper.
