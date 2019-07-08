---
title: Yellowstone National Park Fill Times
excerpt: Avoid the rat race when visiting Yellowstone National Park
published: true
tags: yellowstone national park fill times campground lodges plot data
---

Yellowstone National Park was the worlds first national park. It spans three states and is home to amazing geographic features, wildlife, Yellowstone Lake, and of course the geysers. It is a popular destination for tourists from around the world and accommodation is competitive. If you haven't booked a year in advance you will be surprised by the unusually high hotel pricing when you arrive. 

If you are making last minute plans, there are still some cheap options. The park has first come-first serve campgrounds that you might be able to stay in. The campgrounds, lodges, and hotels are hosted either by the [National Parks Service (NPS)](https://www.nps.gov/yell/index.htm), or a private management company: [Xanterra Travel Collection](https://www.yellowstonenationalparklodges.com/). Searching the internet for reliable information can be difficult as this private company is not forth coming about its distinction from the parks services. Calling their service desk and asking for information can also yield very misleading information, it became clear when talking to them that they avoid answering questions that could direct you to the NPSs services. Even on the NPS website it does not make it clear that certain accommodations are privately managed and at best refer to them as ['concession operated'](https://www.nps.gov/yell/planyourvisit/parkfacts.htm#CP___PAGEID%3D2632122%2C%2Fyell%2Fplanyourvisit%2Fcampgrounds.htm%2C10747%7C) in the facts page.

Here is a map of the park with the campsites and some interesting locations marked:
<iframe src="https://www.google.com/maps/d/embed?mid=1oaACxtvgZdVyeB90YZBtZ4_sg_WZmkUT" width="640" height="480"></iframe>

Campgrounds managed by Xanterra are marked in green:

|                        | Closed                     |
| ---------------------- | -------------------------- |
| Bridge Bay             | September 23 - May 16      |
| Canyon                 | September 23 - May 23      |
| Fishing Bridge RV Park | Closed until 2020          |
| Grant Village          | September 16 - June 6      |
| Madison                | October 21 - April 25      |

Campgrounds belonging to the NPS are marked brown:

|                        | Closed                     |
| ---------------------- | -------------------------- |
| Indian Creek           | September 10 - June 13     |
| Lewis Lake             | November 4 - June 25       |
| Mammoth                | Open year round            |
| Norris                 | September 30 - May 16      |
| Pebble Creek           | September 30 - June 14     |
| Slough Creek           | October 16 - June 14       |
| Tower Fall             | September 30 - May 23      |

Two additional campgrounds were marked outside the park that might be worth looking at. [Lewis & Clark Caverns State Park](http://stateparks.mt.gov/lewis-and-clark-caverns/) has reservable cabins and campsites that do not fill until much later in the year. Eagle Creek Campground is another option but its close proximity to the park will likely have it fill quickly too.

Xanterras campgrounds are reservable and usually book up a year in advance. It is still possible to get into these campsites the day of, if there is a last minute cancellation or someone leaves early. This is not the case for the NPS campgrounds, they are available to the first person to get there the morning you wish to stay and you can keep the campsite for 14 days (during the summer season). If you call the NPS information center they will not provide you with any information on how busy the campsites usually are and advise you to arrive early to wait in line (5-6am). You can not stay in the park outside of designated camp sites, and for someone travelling a great distance there a risk of being stranded outside the park in the middle of the night. The decision to take a gamble on the availability of the NPS campsites should not be taken lightly and thorough research should be done to ensure an enjoyable vacation. [TODO confirm the time campsites begin processing the lineup]

Luckily the NPS provides the time a campsite fills each day on their [website](https://www.nps.gov/yell/planyourvisit/campgrounds.htm). Plotting this data can reveal trends that would aide the decision to visit the park.

Click on an image for an interactive graph of the data.
You can hide parts of the interactive graph by clicking on the legend items.
Hover over a datum for detailed information.

<a href="/assets/posts/2019-07-07-Yellowstone-Fill-Times/Yellowstone-fill-times.html">
<img src="/assets/posts/2019-07-07-Yellowstone-Fill-Times/yellowstone-fill-times.png" width="640" />
</a>

Things to note about this data:
- NPS began recording this information on July 11 2015 and was fetched June 11 2019.
- This is entered manually by park staff and is subject to entry error. Individual data points should be taken with a grain of salt.
- Dates with unreported fill times were assumed to not have filled and were assigned a fill time of 11:59pm that day.
- Locations may not fill because they are not open.
- Duplicate reports on the same day were discarded, keeping the latest. There is a low occurance of this.
- There are only 4 data points per campsite per day (one for each year).
- Hotels and cabins were omited from the plot but were included in the legend.

At first look the parks traffic follows a parabolic trend rather than a inverted normal distribution. It is likely normally distributed but these are campsite fill times and the datas relationship to park traffic is truncated by the capacity of the campgrounds at the upper portion of the graph. The bottom portion of the graphs distribution is clipped or limited by the time in the morning that park attendants begin processing new visitors. 

The data points around Sept 15 before 6am only occurred in 2015 and are possibly due to an issue with staff training when reporting fill times. 

TODO call about weird trend on Aug 27

<a href="/assets/posts/2019-07-07-Yellowstone-Fill-Times/Yellowstone-fill-times-week-aligned.html">
<img src="/assets/posts/2019-07-07-Yellowstone-Fill-Times/yellowstone-fill-times-week-aligned.png" width="640" />
</a>

TODO graph 2 discussion

TODO conclusion

The source code used to generate the graphs is available [here](/assets/posts/2019-07-07-Yellowstone-Fill-Times/report.ipynb).

I am in no way affiliated with the National Parks Service or Xanterra.
