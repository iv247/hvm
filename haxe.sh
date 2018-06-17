#!/bin/bash
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
ln -sfn $HAXEPATH $HVM/versions/haxe/current_version
exec $HAXEPATH/haxe "$@"
