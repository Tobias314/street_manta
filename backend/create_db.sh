#!/usr/bin/env bash

echo "Database creation dev tool usage:"
echo "use --example to create example data (user:test, password:test)"
echo "use --overwrite to overwrite existing database"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Datastore path: $DATASTORE_PATH"
(cd $SCRIPT_DIR && python -m street_manta.tools.create_db $@)
