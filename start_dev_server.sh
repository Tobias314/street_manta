#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
(cd $SCRIPT_DIR/frontend && flutter build web --base-href "/static/")
(cd $SCRIPT_DIR/backend && uv pip install -e .)
(cd $SCRIPT_DIR/backend && uv run uvicorn street_manta.server:app --log-config=log_conf.yaml --port 8080 --host 0.0.0.0 --reload)
