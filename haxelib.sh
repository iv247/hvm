#!/bin/bash
source ~/.hvm/config.sh
# if [[ $HAXE == 3* ]]; then
exec $HAXEPATH/haxelib "$@"
# else
# 	exec haxe -cp $HAXELIBPATH --run tools.haxelib.Main "$@"
# fi
