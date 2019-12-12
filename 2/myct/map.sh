#!/bin/bash 

mkdir "$1$3"
mount --bind $2 "$1$3"
mount -o bind,remount,ro "$1$3"