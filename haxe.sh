#!/bin/bash
BASEDIR=$(dirname "$0")
source $BASEDIR/../config.sh
ln -sfn $HAXEPATH/std $BASEDIR/std
exec $HAXEPATH/haxe "$@"
