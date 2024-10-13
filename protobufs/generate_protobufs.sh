#!/bin/bash

# Should be called from the root directory of the project

# Java/Kotlin
protoc -I=./ --dart_out=frontend/lib/protobufs/ protobufs/sensors.proto
# Python
protoc -I=./ --python_out=backend/app/ protobufs/sensors.proto