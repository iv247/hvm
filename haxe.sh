#!/bin/bash
source ~/.hvm/config.sh
mkdir -p ~/.hvm/versions/haxe/current_project
ln -sfn $HAXEPATH/std ~/.hvm/versions/haxe/current_project/std
exec $HAXEPATH/haxe "$@"
