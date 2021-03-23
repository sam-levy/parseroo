#!/bin/sh
set -e

/app/bin/parseroo eval "Parseroo.Release.migrate()"

/app/bin/parseroo start
