# Good Neighbor iOS App

*Good Neighbor* is an iOS app that "spreads generosity" as you interact with the local community. It surfaces news local to your city alongside recommended non profits
to donate to as defined by the article author. This example is designed to spark your creativity with what is possible to build with the [Daffy Public API](https://docs.daffy.org/)!

<p align="center" float="left">
	<img src="images/app-splash-screen.png?raw=true" width=200>
	<img src="images/app-home-screen.png?raw=true" width=200>
	<img src="images/app-recording.gif?raw=true" width=200>
</p>

## Setup
All that is needed to setup the app is a complete setup of XCode. Download & follow installation instructions per Apple guidelines [here](https://developer.apple.com/xcode/).

### Starting the app
Open the `Good Neighbor.xcodeproj` file in Xcode then press the "run" button at the top left corner of the IDE. 
A simulator should show up with the `Good Neighbor` app up and running. That's it!

### Interacting with the app
A Daffy Public API key is necessary to actually enter into the app experience and perform the necessary authenticated requests. 
You can retrieve one by following the instructions [here](https://docs.daffy.org/auth).

## Overview
This app mocks the existense of a news feed where authors define a curated set of non profits relevant to a specific news article. 
The app is designed with MVVM architecture, where a data layer that interacts with the Daffy Public API has already been setup with real connections to endpoints that the app relies on.
For learning purposes, there are some endpoints left with no actual API implementation and others that are implemented but unused in the app.

### Features
The app is able to access the iOS device's current location and utilize it to show only news articles that are defined in the same location. Each news article can suggest a set of non profits to donate to, as well as various donation amount recommendations. When at least one donation is made, the most recent one is shown on the landing page.

#### Supported Locations
Since we mock news articles, there are only a small set of locations we defined with the appropriate mock data:

|Location|Latitude|Longitude|
|---|---|---|
|San Francisco, CA|`37.773972`|`-122.431297`|
|Salt Lake City, UT|`40.758701`|`-111.876183`|
|Boston, MA|`42.361145`|`-71.057083`|

Use these longitude/latitude values to change the location of the iOS simulator while testing. You can do this on your simulator by going to `Features > Location > Custom Location`. 
If none of the specified locations above match the device location, all mock data is surfaced.

## ✨ Inspiration ✨
Here are some features that would be a good introduction to interacting with the Daffy Public API and enhancing the app experience:
1. *Suggest non profits on news articles by location.* Instead of always defining non profits to an article, we can use search features to automatically suggest some. A `searchNonProfits` implementation is there to aid you!
2. *Actually create real donations.* There are TODOs marked where the implementation for "creating a donation" with the Daffy Public API is intentionally omitted and instead donations
are created/shown from memory. There are donation APIs that can be used in place of this!
