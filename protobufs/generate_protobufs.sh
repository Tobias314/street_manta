#!/bin/bash

# Should be called from the root directory of the project

# Flutter/Dart
rm -rf frontend/lib/protobufs
protoc -I=./ --dart_out=frontend/lib/ protobufs/geo_capture.proto
# Python
rm -rf backend/app/protobufs
protoc -I=./ --python_out=backend/src/street_manta/ protobufs/geo_capture.proto
