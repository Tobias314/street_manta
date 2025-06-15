#!/bin/bash

# Allow running the script from any directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

uv run pytest -s --log-cli-level=INFO tests