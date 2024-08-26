#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Datastore path: $DATASTORE_PATH"
(cd $SCRIPT_DIR &&python -m app.tools.create_db $@)
