grammophon
==========

nifty frontend for <del>upcoming</del> distributed, decentralized music management. 

idea
------
At first I tried to reinvent something that was already there: [__playdar__](http://github.com/RJ/playdar-core)  
Try to grasp the idea behind __playdar__ first, being able to enter any artist/track combination and let playdar to the heavy lifting, in this case _get the nearest location from where you can play that song_. Now combine this with your average music consumption and you might realize that there's still a need for management. Something that __playdar__ itself doesn't and _by design_ will not offer.  

People use __iTunes™__ for a reason, not because they love apple so much, but because it takes the load of music (and sadly recently media) management off your back. It's elegant and easy to use.  

So you might ask: 
>    _what's wrong with using iTunes?_

There's nothing wrong with the _original idea_ behind __iTunes__, it's the current state of the _implementation_. The concept of __UNIX's__ command line applications applied to GUI-based apps, "let __one__ application do __one__ thing only and therefore do it __extraordinary well__", has seen it's manifestation in the __OPENStep__ draft and current implementation in Apple's __Mac OS X__. Your operating system should have __one__ application to manage your contacts, __one__ for managing your calendar, __one__ for looking up words, __one__ for viewing documents... the list goes on. I appreciate Apple's way of doing that and therefore I am using it, despite the fact that I don't like this company _at all_.  

They _did_ a good job, but now we're in the age of cloud-computing, constant internet connection and so on. Times have changed and what once was a simple _music player_ called iTunes, is now merely a host for random upcoming store shelves for the Apple company, selling and trying to manage everything not limited to music anymore. 

Let's face it:
>    __iTunes__ has become the most bloated piece of software, avenged to the league of horrible things like __eclipse__ or the __ICQ__-client.  

They failed at the heart of their current operating system, letting their former __music player__ become an operating system itself, throwing away the aforementioned concept of "do __one__ thing and do it well".  

One should take into account that Apple is still a company and they deploy iTunes to __Mac OS X__ as well as Windows, so there is little reason why they shouldn't put their main selling product (the iTunes-Store frontend) into their most used desktop application.  
Fair enough, but I _want_ that simplicity, I _want_ that "do __one__ thing and do it well" concept, especially for my music, but also for movies and maybe even music videos. I _want_ separate applications for that and I want each of them to network. That's the main argument why I don't want to use iTunes anymore.  
Apple's implementation of the DAAP-Protocol in iTunes is a joke. I don't want to log into my iTunes-Store account to hear streamed music form the computer standing next to me.  
Let's repeat, "__playdar__ let's me hear the songs I want, from the nearest location that has it available", so to put it with [jchris'](http://github.com/jchris) words ["This is not a technology problem, it's a problem of imagination."](http://jchrisa.net/drl/_design/sofa/_show/post/Imagine-There-s-No-YouTube).  
[__playlick__](http://playlick.com) is the first part of the puzzle, but for me, it lacks a lot of stuff, mainly it lacks the desktop-application-feeling.  
This project is an attempt to build exactly that, a "desktop-like" application serving just one purpose _managing the music you listen to, regardless of where it is physically located_. Think of it as the [__grooveshark__](http://grooveshark.com/) but without the necessary coupling to the cloud. If there's a song on your harddrive, then you can play it. If it is just available on youtube, then you can play it. I really like grooveshark, but the fact, that their database is far away from complete and predictably will always be, renders it useless to me. 

Implementation
--------------------
At first I wanted it to be a Cocoa application, hence Mac OS X only.  
Great, nothing wrong with that, Cocoa offers a great potential for building efficient and elegant applications, but it's limited to one platform and still, Apple's mashup-capabilities for Software development are kind of...non-existant.  
So currently this project is using Adobe's Flash runtime, specifically the Flex 4 SDK and the [robotlegs-framework](http://github.com/robotlegs/robotlegs-framework), but one should consider this a _proof-of-concept_, an idea put into bits. In the future there may be native applications for each platform, but for now Flash serves well being available on all major platforms.  
I started implementing [dynamic crossdomain.xml generation into playdar-core](http://github.com/lennart/playdar-core/tree/crossdomain) to allow flex applications to interface with your local playdar daemon. I use imlucas' as3playdar to interface with playdar and started to integrate blip.fm read-only support (which is one of the sources I wanted to have access to). At the current stage, simple search, blip.fm feed-loading, resolving, playlist building and playing works. That said, there is apparently nothing of the mentioned _managing_ capabilites integrated. 

Usage
--------
I try to keep a working up2date version hosted on the corresponding github-page for this project. You currently need a crossdomain-enabled built of playdar installed on you local computer and there are no prebuilt installers yet. One could pretty much say, this is still a developers project and not usable for anyone else. However, as soon as the crossdomain support is merged into playdar, using it should be as simple as clicking on the "Playdar.prefpane", or the "Windar Installer" and you're done.

The Future™
-----------------
I cannot resist to use [couchdb](http://couchdb.apache.org/) as the database for the music metadata, sadly there is currently no native erlang implementation of [lucene](http://lucene.apache.org/java/docs/) or any other search-indexer. 