#!/bin/bash

VERSION=2.0.0

export HVM=~/.hvm
export PATH=$PATH:$HVM/bin

PATH_PREFIX=$HVM/bin

source $HVM/config.sh

hvm_get_haxe_versions() {
	HAXE_VERSIONS=()
	local VERSIONS=`curl --silent https://haxe.org/download/list/ 2>&1 | grep -oE 'version\/[^/]+' | cut -d / -f 2 | awk '!a[$0]++'`
	for VERSION in $VERSIONS; do
		HAXE_VERSIONS+=($VERSION)
	done
}

hvm_get_neko_versions() {
	NEKO_VERSIONS=("1.8.1" "1.8.2" "2.0.0" "2.1.0" "2.2.0")
}

hvm_valid_version() {
	if [ "$1" == "dev" ]; then
		return 0
	fi
	local e
	for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
	echo "version $1 was not one of ${@:2}"
	return 1
}

hvm_save_current() {
	rm -f $HVM/current.sh
	echo "export NEKO=$NEKO" >> $HVM/current.sh
	echo "export HAXE=$HAXE" >> $HVM/current.sh
}

hvm() {
	case $1 in
	"use" )
		case $2 in
		"haxe" )
			HAXE=$3
			if [ "$HAXE" == "latest" ]; then
				rm -rf $HVM/versions/haxe/dev
				HAXE="dev"
			fi
			hvm_get_haxe_versions
			hvm_valid_version $HAXE ${HAXE_VERSIONS[@]} && hvm_save_current
			source $HVM/config.sh
		;;
		"neko" )
			NEKO=$3
			if [ "$NEKO" == "latest" ]; then
				rm -rf $HVM/versions/neko/dev
				NEKO="dev"
			fi
			hvm_get_neko_versions
			hvm_valid_version $NEKO ${NEKO_VERSIONS[@]} && hvm_save_current
			source $HVM/config.sh
		;;
		* )
			echo "binary \"$2\" was not one of (neko haxe)"
			return
		;;
		esac
	;;
	"install" )
	    mkdir -p $HVM/bin
		ln -sf $HVM/haxe.sh $PATH_PREFIX/haxe
		ln -sf $HVM/haxelib.sh $PATH_PREFIX/haxelib
		ln -sf $HVM/neko.sh $PATH_PREFIX/neko
		ln -sf $HVM/nekotools.sh $PATH_PREFIX/nekotools
		ln -sf $HVM/nekoc.sh $PATH_PREFIX/nekoc
		ln -sf $HVM/nekoml.sh $PATH_PREFIX/nekoml
		source $HVM/config.sh
	;;
	"versions" )
		case $2 in
		"haxe" )
			hvm_get_haxe_versions
			for VERSION in "${HAXE_VERSIONS[@]}"; do
				echo "$VERSION"
			done
		;;
		"neko" )
			hvm_get_neko_versions
			for VERSION in "${NEKO_VERSIONS[@]}"; do
				echo "$VERSION"
			done
		;;
		* )
			echo "binary \"$2\" was not one of (neko haxe)"
			return
		;;
		esac
	;;
	"help" | * )
		echo "Haxe Version Manager $VERSION"
		echo "Usage: hvm use (neko|haxe) (latest|dev|1.2.3)"
	;;
	esac
}
