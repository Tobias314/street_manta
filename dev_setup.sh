#!/bin/bash

# Allow running the script from any directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

dart pub global activate protoc_plugin

cd $SCRIPT_DIR/frontend
dart pub get
