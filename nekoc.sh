#!/bin/bash
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
exec $NEKOPATH/nekoc "$@"
