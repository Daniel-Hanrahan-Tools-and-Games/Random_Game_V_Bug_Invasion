#!/bin/bash
cd "$(dirname "$0")"
WINEPREFIX=~/.wine wine pixi.exe -w super_mario_world.sfc

