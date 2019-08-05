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

| Campsite              | Closed                     |
| ---------------------- | -------------------------- |
| Bridge Bay             | September 23 - May 16      |
| Canyon                 | September 23 - May 23      |
| Fishing Bridge RV Park | Closed until 2020          |
| Grant Village          | September 16 - June 6      |
| Madison                | October 21 - April 25      |

Campgrounds belonging to the NPS are marked brown:

| Campsite               | Closed                     |
| ---------------------- | -------------------------- |
| Indian Creek           | September 10 - June 13     |
| Lewis Lake             | November 4 - June 25       |
| Mammoth                | Open year round            |
| Norris                 | September 30 - May 16      |
| Pebble Creek           | September 30 - June 14     |
| Slough Creek           | October 16 - June 14       |
| Tower Fall             | September 30 - May 23      |

Two additional campgrounds were marked outside the park that might be worth looking at. [Lewis & Clark Caverns State Park](http://stateparks.mt.gov/lewis-and-clark-caverns/) has reservable cabins and campsites that do not fill until much later in the year. Eagle Creek Campground is another option but its proximity to the park will likely have it fill quickly too.

Xanterras campgrounds are reservable and usually book up a year in advance. If there is a last minute cancellation or someone leaves early it is still possible to get into these campsites the day of. This is not the case for the NPS campgrounds, they are available to the first person to get there the morning you wish to stay and you can keep the campsite for 14 days (during summer). If you call the NPS information center they will not provide you with any information on how busy the campsites usually are and advise you to arrive early to wait in line (5-6am). Campsite offices open at 7:30am each day and begin processing new visitors. You can not stay in the park outside of designated camp sites, and for someone traveling a great distance there is a risk of being stranded outside the park in the middle of the night. The decision to take a gamble on the availability of the NPS campsites should not be taken lightly and thorough research should be done to ensure an enjoyable vacation.

*Note: If you don't care about pretty graphs just skip to the end.*

NPS provides the time a campsite fills each day on their [website](https://www.nps.gov/yell/planyourvisit/campgrounds.htm). Plotting this data can reveal trends that would aide the decision to visit the park. 

For the remainder of this analysis it will be assumed that earlier fill times are caused by higher demand and higher park traffic. This is not necessarily true as visitor behavior is complex and there can be additional factors that might motivate people to arrive at the park at different times, on different dates. The goal is to observe qualitative trends rather than produce quantitative conclusions.

Click on an image for an interactive graph of the data.
You can hide parts of the interactive graph by clicking on the legend items.
Hover over a datum for detailed information.

<figure>
  <a href="/assets/posts/2019-07-07-Yellowstone-Fill-Times/Yellowstone-fill-times.html">
  <img src="/assets/posts/2019-07-07-Yellowstone-Fill-Times/yellowstone-fill-times.png" width="640" />
  </a>
  <figcaption>Figure 1 - Yellowstone Campsite Fill Times</figcaption>
</figure>

Things to note about this data:
- NPS began recording this information on July 11 2015 and was fetched June 11 2019.
- This is entered manually by park staff and is subject to entry error. Individual data points should be taken with a grain of salt.
- Dates with unreported fill times were assumed to not have filled and were assigned a fill time of 11:59pm that day.
- Locations may not fill because they are not open.
- Duplicate reports on the same day were discarded, keeping the latest. There is a low occurrence of this.
- There are only 4 data points per campsite per day (one for each year).
- Hotels and cabins were omitted from the plot but were included in the legend. You can plot these by modifying the last line of code linked at the bottom of this page.
- Fill times reported before 7:30am are due to the site continuing to be full from the previous day.

Looking at figure 1 reveals a few trends:

The data points around Sept 15 before 6am only occurred in 2015 and are possibly due to an issue with staff training when reporting fill times. 

Campsite fill times and the datas relationship to park traffic is truncated by the capacity of the campgrounds at the upper portion of the graph. The bottom portion of the graph is clipped or limited by the time in the morning that park attendants begin processing new visitors. 

Mammoth campground is the only one open year round, all other campsites close for the Fall and Winter seasons. Traffic at Mammoth increases at the beginning of April and gets busier until after the other campsites open where its attendance drops, likely as other campsites are preferred. Attendance drops until mid June where the park begins to saturate during its busiest period, late July to mid August. This trend repeats as the park exits its busy period. Mammoths attendance drops until the beginning of September where it increases as the other campsites season comes to an end.

The top of figure 1 shows that the park completely and consistently fills between July 15 and Aug 1. With only two datum exceptions, the park fills all the way to Aug 11 where competition for campsites begins to drop.

Xanterras campgrounds largely fill before 8am throughout the season. Fishing Bridge RV park seems to be the most available relative to the other Xanterra campgrounds. Canyon and Grant village campgrounds are equally busy although Grant Village opens later in the season.

Xanterras campgrounds appear to suddenly and consistently start filling an hour later after August 26. Several staff of both Xanterra and NPS were asked about this trend and no one was aware of it or could explain it. Given its proximity to the end of the busy period and the jump is to about 7:30am, it can be speculated that there is a threshold being passed where reservations are ending and campsites are not remaining full from the previous day. Xanterra is then accepting new visitors and reporting the fill time afterwards. 

NPS doesn't follow this trend as closely but looking at Lewis Lake, Tower Fall, and Norris campgrounds, there is a distinct jump in fill time around that date. Including Mammoth, demand for these campsites slowly begins to increase until the end of the season. August 27 may represent a sudden demographic shift in vistors, with a different vacationing culture or schedule. 

Slough Creek and Pebble Creek do not follow any of the aforementioned trends and stay consistently busy while they are open. This may also represent a different demographic that come for the activities available at these specific campgrounds.

Given the predominant Monday to Friday work culture of the United States, the following graph attempts to align the weekdays of each year to observe any possible weekender demographic trends.

<figure>
  <a href="/assets/posts/2019-07-07-Yellowstone-Fill-Times/Yellowstone-fill-times-week-aligned.html">
  <img src="/assets/posts/2019-07-07-Yellowstone-Fill-Times/yellowstone-fill-times-week-aligned.png" width="640" />
  </a>
  <figcaption>Figure 2 - Yellowstone Campsite Fill Times, Week Aligned</figcaption>
</figure>

Things to note about this data:
- 2018 is the only year to align to the horizontal axis as January 1 2018 was a Monday.
- It is possible that there is justification to align a year a week later than currently displayed. That relationship would be complex and the mathematically simplest method was chosen.

Surprisingly the weekend trend is opposite of what was initially expected. This trend mostly appears during the July 15 to August 15 busy period as it is obscured by the fact that the campgrounds don't consistently fill otherwise. It appears that campsites fill later in the day on weekends. This is likely due to high turnover as the people who stayed for more than the weekend return home. This would also explain the fill times Monday to Friday, people in the park on those dates are staying for the entire week. With low turnover, the campsites remain full and earlier fill times are reported.

What to make of all of this
---------------------------

There are some useful things you can extract from this data when planning a trip to Yellowstone National Park. The most obvious is to try and avoid visiting between July 15 and August 15, those dates are significantly busier than the rest of the year. Avoid Xanterras campgrounds if you can't get a reservation. You are more likely to get a last minute spot at one of the NPS campsites.

Aim for Norris or Indian Creek campgrounds if you can't get there early. Even during the busy period you should be able to get a spot before 11am. Mammoth is another safe bet but may not be a preferred location. Lewis Lake starts to clear out after August 1 if you prefer that location and need to plan your visit during that time. Tower Fall appears to be the last best option and you should plan to arrive before the park offices open at 7:30am if you want a spot during their busy dates.

Pebble Creek and Slough Creek are consistently busy, if you are not specifically interested in the attractions at those locations then consider alternatives first. If you do want that location make sure to arrive before 7:30am.

August 27 is possibly the best date to arrive on later in the season. The trend in the campsites at that time is too good to not take advantage of.

Regardless of all of this, you should try to plan your accommodation around the activities you intend to do in the park. Once you choose a location, have a look at the graphs above and filter out all but that location and look at the trends around your intended dates. Clicking on the image of the graph will take you to an interactive version where you can click on the legend items to hide them, zoom in on the date range you want, and pan around to consider alternative dates.

Good luck on your adventure and remember that plans failing are what makes it an adventure. Just make sure you are sufficiently prepared.

The source code used to generate the graphs is available [here](/assets/posts/2019-07-07-Yellowstone-Fill-Times/report.ipynb) as a IPython Notebook.

I am in no way affiliated with the National Parks Service or Xanterra. This data is presented as is and you should draw your own conclusions when making decisions. I take no responsibility for any outcome resulting from this data or analysis and do not attest to its accuracy or truthfulness. Data is presented under the Fair Use clause of the USA Copyright Act.
