#!/bin/bash

# Allow running the script from any directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

# Flutter/Dart
rm -rf frontend/lib/protobufs
protoc -I=./ --dart_out=frontend/lib/ protobufs/geo_capture.proto
# Python
rm -rf backend/app/protobufs
protoc -I=./ --python_out=backend/src/street_manta/ protobufs/geo_capture.proto
