#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
(cd $SCRIPT_DIR/../frontend && flutter build web)
(cd $SCRIPT_DIR && uv run fastapi dev --port 8080 "src/street_manta/server.py" --host 0.0.0.0)
