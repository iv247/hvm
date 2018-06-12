#!/bin/bash
source ~/.hvm/config.sh
ln -sfn $HAXEPATH/std ~/.hvm/versions/haxe/current_project/std
exec $HAXEPATH/haxe "$@"
