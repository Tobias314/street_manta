FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

# avoid stuck build due to user prompt
ARG DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN apt update -y && apt upgrade -y;
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa ffmpeg libsm6 libxext6 python3 python3-dev python3-venv python3-pip python3-wheel build-essential libc6:amd64 libstdc++6:amd64 libbz2-1.0:amd64 unzip
RUN apt-get install -y openjdk-17-jdk openjdk-17-demo openjdk-17-doc openjdk-17-jre-headless openjdk-17-source 

# Install Android CLI tools
RUN curl -o android_cli_tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
RUN unzip ./android_cli_tools.zip -d android_cli_tools
RUN mkdir Android
RUN mkdir Android/cmdline-tools
RUN mv android_cli_tools/cmdline-tools Android/cmdline-tools/latest
RUN mv Android /usr/lib/Android
ENV ANDROID_HOME=/usr/lib/Android
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/:$PATH
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
# accept all licenses
RUN sdkmanager --update
RUN yes | sdkmanager --licenses
# RUN sdkmanager "platforms;android-29"
# RUN sdkmanager "platform-tools"
# RUN sdkmanager "build-tools;29.0.2"

# Install Flutter
RUN curl -o flutter_linux.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.1-stable.tar.xz
RUN tar -xf flutter_linux.tar.xz -C /usr/bin/
RUN git config --global --add safe.directory /usr/bin/flutter
ENV PATH="${PATH}:/usr/bin/flutter/bin"
RUN flutter config --android-sdk /usr/lib/Android
RUN cd /tmp && flutter create tmp_flutter_app 
# Build a simple flutter app to automatically download and cache of android sdk etc.
RUN cd /tmp/tmp_flutter_app  && flutter build apk
RUN rm -rf /tmp/tmp_flutter_app
RUN flutter doctor -v

# Install frontend dependencies
COPY frontend/macos /street_manta/frontend/macos
COPY frontend/linux /street_manta/frontend/linux
COPY frontend/ios /street_manta/frontend/ios
COPY frontend/plugins /street_manta/frontend/plugins
COPY frontend/android /street_manta/frontend/android
COPY frontend/web /street_manta/frontend/web
COPY frontend/.metadata /street_manta/frontend/.metadata
COPY frontend/pubspec.yaml /street_manta/frontend/pubspec.yaml
WORKDIR /street_manta/frontend
RUN flutter upgrade
RUN flutter clean
#RUN rm pubspec.lock
RUN flutter pub get
RUN flutter packages get
# Bulding a dummy app to download and cache dependencies
RUN mkdir lib
RUN echo 'import "package:flutter/material.dart";Future<void> main() async {runApp(const MyApp());}class MyApp extends StatelessWidget {const MyApp({super.key});@override Widget build(BuildContext context) {return Text("Hello, World!");}}' > lib/main.dart
RUN flutter build apk --dart-define=BACKEND_URL=${BACKEND_URL} lib/main.dart
RUN rm lib/main.dart

# Install backend dependencies
COPY backend/requirements.txt /street_manta/backend/requirements.txt
WORKDIR /street_manta/backend
RUN python3 -m venv /home/myuser/venv
ENV PATH="/home/myuser/venv/bin:$PATH"
#RUN python --version
RUN pip install --no-cache-dir -r requirements.txt


ARG BACKEND_URL="https://streetmanta.redpielabs.com:4343"

# Build frontend
COPY frontend/assets /street_manta/frontend/assets
COPY frontend/lib /street_manta/frontend/lib
WORKDIR /street_manta/frontend
RUN echo "Building with BACKEND_URL: ${BACKEND_URL}"
RUN flutter build web --base-href /static/ --dart-define=BACKEND_URL=${BACKEND_URL} -t lib/main.dart
RUN flutter build apk --dart-define=BACKEND_URL=${BACKEND_URL} lib/main.dart
RUN mkdir -p build/web/app/android
RUN cp build/app/outputs/flutter-apk/app-release.apk build/web/app/android/streetmanta.apk

# Build Backend
WORKDIR /street_manta/backend
COPY backend/create_db.sh /street_manta/backend/create_db.sh
COPY backend/tests /street_manta/backend/tests
COPY backend/src /street_manta/backend/src
# create and activate virtual environment
# using final folder name to avoid path issues with packages
# Expose the port that FastAPI will run on
EXPOSE 80

WORKDIR /street_manta/backend
# Command to run the application using uvicorn
ARG DATASTORE_PATH="/datastore"
CMD DATASTORE_PATH="/datastore" ./create_db.sh && uv pip install . && uv run fastapi run street_manta.server:app --host 0.0.0.0 --proxy-headers --port 80



