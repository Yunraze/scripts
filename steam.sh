#!/usr/bin/env bash

exec flatpak run com.valvesoftware.Steam -cef-disable-gpu-compositing -cef-disable-gpu steam://open/minigameslist %U
