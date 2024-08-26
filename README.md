# Street Manta
Street Manta is an open-source application that facilitates road maintenance and management. In its current version, it includes a mobile application for Android devices that captures geotagged photos that are then sent to a central server. All photos captured under one password-protected user account can be viewed on a map, managed, and shared via a desktop-friendly web application.

The below video gives a short overview over the current functionality of Street Manta (click the picture to play).

[![Street Manta video thumbnail](http://img.youtube.com/vi/LJVJ2vrBVyU/0.jpg)](http://www.youtube.com/watch?v=LJVJ2vrBVyU "Street Manta")

The goal of Street Manta is to contribute to the digitalization of small to medium-sized local governments by providing easy-to-use open-source software for simple but common use cases in the field of road maintenance. 

# Demo
A demo version of Street Manta can be found under:
[https://streetmanta.redpielabs.com/](https://streetmanta.redpielabs.com/)

Please note that this deployment is for demonstration purposes only and should not be used in production!

# Features
- Android app to capture geo-tagged (via the devices' GPS sensor) photos with additional descriptions
- Upload captured photos to a (self-hosted) server for centralized storage and easy access from any device
- Automatic capture mode: mount the mobile device behind the windscreen of a car or on the handlebar of a bike and automatically capture multiple geotagged photos at a fixed rate (fixed distance between shots).
- Management of captured photos on a map accessible both from the mobile app as well as from a browser-based web app suitable for desktop clients
- Preview of downsampled thumbnails on the map to limit bandwidth when viewing the map
- Password-based user management to prevent captured data from unauthorized access
- Easy installation: the server which provides the web app can run as a docker container, the Android app can then be installed directly from the Browser via the web app (no third-party app store required)
- More to come...

# Contributing
The project currently still is in its infancy. More work and features are required. For that any help is welcome. If you are interested, just get in contact, spread the word, leave a start, a comment or even open a PR.

## Possible Future Features
- User groups as well as administration accounts to create and manage users and user groups
- Semantic tags to group and filter captured photos
- Usage of freely available differential GPS data to improve spatial accuracy

# FAQ
- Why is the UI in German?
   - The idea for the project originates from the observation that road maintenance in German municipalities is often done without specialised digital tools or using costly software which is not freely available/open-source.
- Why is most of the code prototypical or even ugly?
    - Currently, the project is still more or less a prototype in an early stage. This should change in the future. If this bothers you and you want to change it rather sooner than later feel free to contribute :) 
