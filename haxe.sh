#!/bin/bash
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
ln -sfn $HAXEPATH/std $HVM/versions/haxe/current_project/std
exec $HAXEPATH/haxe "$@"
