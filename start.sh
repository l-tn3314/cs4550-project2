#!/bin/bash

export MIX_ENV=prod
export PORT=4995

echo "Stopping old copy of app, if any..."

_build/prod/rel/project2/bin/project2 stop || true

echo "Starting app..."

# Start to run in background from shell.

#_build/prod/rel/project2/bin/project2 foreground
MIX_ENV=prod PORT=4995 mix phx.server
