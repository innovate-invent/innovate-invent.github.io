---
title: ChatStream
excerpt: A client side only embedded chat overlay for various streaming platforms
tags: [ youtube, twitch, discord, overlay, chat, streaming, OBS ]
at_url: at://did:plc:gdfkbwgnydyn4xgea7e7e6ht/app.bsky.feed.post/3m3wtkaqnzc25
---

Planning to stream my development of a new linux distribution, and wanting to reach a broad audience, I wanted to stream
to multiple streaming platforms. The primary reason for streaming the development process is to get realtime feedback
and insight from others on the design and implementation of the distribution. Streaming to multiple platforms means I
would have multiple accompanying chat feeds for each platform. To avoid excluding any of the audiences from the
conversation I needed a solution that would combine the chat feeds and overlay the combined chat on the video stream for
everyone to see.

Looking around at the currently available options, I found a lot of great solutions with rich feature sets.
Unfortunately most of them either only supported a single streaming service, were paid services targeting people looking
to profit from streaming, or just didn't fit my use case.

Frustrated with the compromises I was being forced into, I had a peek at how hard it would be to write my own solution.
The platforms all expose APIs for integrations and all expose some means of accessing the real time chat history.

"This shouldn't be too difficult" -- A poor unwitting younger me

Unsurprisingly Twitch has the easiest to integrate API, but the worst TOS restrictions. They have conflicting policies
that both allow you to stream to multiple platforms on the condition that you have similar experiences between them (you
mustn't provide a better experience on a different platform than Twitch), but you are not allowed to display content
from other platforms on Twitch. Rather than implement this in code anywhere I just chose to note some possible
workarounds in the documentation that finds some middle ground between the two policies.

YouTube was the worst to integrate with. Its API feels like it was designed in 2005, requiring you to poll the API. Just
when I thought I was done implementing the code for this integration, I found that YouTube has an API request quota
restriction that is prohibitively low. With so much effort already sunk into integrating with YouTube I decided to
attempt a YouTube API quota increase request. What a nightmare. This particular API Quota comes with client application
compliance requirements. These requirements were written assuming another web *service* would be consuming the chat data
rather than a standalone client. I tried to reason with them, but it became clear that I was fighting with a poorly
implemented AI agent that I had to submit a web url to, and would then assess compliance based on the content of the web
page. They forced me to publish a Terms of Service and Privacy Policy for my non-service that doesn't store data
anywhere but locally. They also have this insanely strict requirement for how the content is displayed. A pixel perfect
YouTube logo must be displayed beside the content, not even the Font Awesome version of the YouTube logo was sufficient.
I had to do some wizardry with a CSS radial gradient to get it approved. The craziest thing is they actually use pixel
dimensions in their requirements, meaning that if you are running a lower resolution monitor, the logo that is supposed
to be inline with the text ends up being ~20% of the screen width. I had to increase the default font size just to make
it not look terrible alongside the other content (luckily the end user can easily adjust the font size and logo). It
took maybe 40 emails (I migrated email providers in that time and lost track) back and forth before it would approve me,
finally sending me to what I can only assume was a human for the final review. Then it took over 6 months of waiting for
that final review before the quota was approved. The approval came with a warning that if ChatStream doesn't become an
immediate hit with large usage that they will cut back the quota and require me to go through another 6 month approval
process. /rant

You might not think of Discord as a streaming service, but it is, just not easy to monetise with advertising like the
others. I am not streaming for money so I want to include this platform. Unfortunately Discords API is lagging in
features, and they only support "bots" accessing the chat data. This means that the end user needs to go through the
manual process of creating and registering a bot in their developer portal rather than just using your own Discord
credentials.

Other than those speed bumps it was actually a fairly small project, I think I spent two weekends on it (other than
emails). One weekend for the code, and the other for the CSS. I will always underestimate the amount of work it takes to
define a UI. So many time consuming fiddly tweaks to get it to look right (and it still needs more).

All that said, I present to you [ChatStream](https://chatstream.i2labs.ca), free for your use.