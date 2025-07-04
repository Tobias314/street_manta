# Street Manta
Street Manta is an open-source application that facilitates road maintenance and management. In its current version, it includes a mobile application for Android devices that captures geotagged photos that are then sent to a central server. All photos captured under one password-protected user account can be viewed on a map, managed, and shared via a desktop-friendly web application.

The below video gives a short overview over the current functionality of Street Manta (click the picture to play).

[![Street Manta video thumbnail](http://img.youtube.com/vi/LJVJ2vrBVyU/0.jpg)](http://www.youtube.com/watch?v=LJVJ2vrBVyU "Street Manta")

The goal of Street Manta is to contribute to the digitalization of small to medium-sized local governments by providing easy-to-use open-source software for simple but common use cases in the field of road maintenance. 

> :warning: **This repository is still work in progress! Heavy construction is ongoing and things might change rapidly. Information might be outdated, features might have changed or be currently broken! Use at your own risk!**

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
The project currently still is in its infancy. More work and features are required. For that any help is welcome. If you are interested, just get in contact, spread the word, leave a comment or even open a PR.

## Possible Future Features
- User groups as well as administration accounts to create and manage users and user groups
- Semantic tags to group and filter captured photos
- Usage of freely available differential GPS data to improve spatial accuracy

# FAQ
- Why is the UI in German?
   - The idea for the project originates from the observation that road maintenance in German municipalities is often done without specialised digital tools or using costly software which is not freely available/open-source.
- Why does most of the code look rather prototypical (some might also call it ugly)?
    - Currently, the project is still more or less a prototype in an early stage. This should change in the future. If this bothers you and you want to change it rather sooner than later feel free to contribute :) 

# Developer Setup
The project consists of a Flutter frontend and a Python backend (which also serves the frontend files). Here we give some advises on how to locally build and run the project

## Flutter Frontend
Both the Android app and the web app are built from the same codebase using Flutter. In theory this should also allow building apps for several other platforms like iOS, however, this has not been tested yet.

To build the app we provide an example using Visual Studio Code (vscode) under Ubuntu, however, you can obviously choose any other IDE or editor of your liking. In vscode you can simply install the "Flutter" extension to get language support and integrated support for the most important build tools. If required, this will also suggest you to install the required flutter and dart tools (make sure to also add them to your PATH in case you also want to call them from a shell).

If things are not set up automatically you could look [here](https://docs.flutter.dev/get-started/install/linux).

### Web App
Building and running the web app should work out of the box from within vscode as long as either the Chrome or Chromium browser is installed on your system (your might have to set the `CHROME_EXECUTABLE` environment variable accordingly). In that case you can select Chrome as Flutter device (e.g. by pressing Ctrl+Shift+P and then select "Flutter: Select Dive" followed by selecting Chrome). You are then able to run the app by clicking the arrow symbol that appears in the top right corner of vscode when you have the frontend/lib/main.dart file open.

Alternatively, you can also build the web app from the commend line by running:

`BACKEND_URL="http://localhost:8080" cd frontend && flutter build web --base-href /static/ --dart-define=BACKEND_URL=${BACKEND_URL} -t lib/main.dart`

 from within the frontend/ directory. Make sure to either have the backend server running or adapt the `BACKEND_URL` environment accordingly variable to point to a public backend server (e.g. https://streetmanta.redpielabs.com:4343).

### Android App
To build for Android you require some additional tooling like the Android SDK. The easiest way to get it might be to install Android Studio. [The official Flutter documentation](https://docs.flutter.dev/get-started/install/linux/android) gives you a good tutorial about how to setup your development environment. Since different versions of Android Studio might use different Java and Gradle versions there might be compatibility issues and some required adaptions whenever a new version of Android Studio is released. Currently, building the project is tested using Android Studio Ladybug, so using this version might give the best compatibility. After installing all requirements you can select an Android device from within vscode in the same way you did with Chrome when building the web app (you might either choose an emulator or a physically connected Android device) and then run the app from within vscode.

Alternatively you can also build an .apk file using the following command executed from within the frontend directory:
`BACKEND_URL="http://10.0.2.2:8080" flutter build apk --dart-define=BACKEND_URL=${BACKEND_URL} lib/main.dart`

Pay attention to setting a valid BACKEND_URL. E.g. you need to specify http://10.0.2.2:8080 if you want to connect from within the Android emulator to your backend server running at localhost:8080 of your host machine.

### Building Protocol Buffers
To compile protocol buffers (.proto) files you need to install the protoc compiler e.g. by finding and installing the latest release via the [offical protobuf page](https://protobuf.dev/downloads/). In addition, to build the dart files from the .proto specification you also need to install the Dart plugin for the protoc compiler e.g. by following the description on [this site](https://github.com/google/protobuf.dart/tree/master/protoc_plugin#how-to-build). If all is set up correctly you can now run:

`./protobufs/generate_protobufs.sh` 

from the repository root directory to generate the Python and Dart files from the .proto specification.