#!/usr/bin/env bash

v4l2-ctl \
	--set-fmt-video=width=1280,height=720,pixelformat=MJPG \
	--set-ctrl=brightness=150 \
	--set-ctrl=contrast=51 \
	--set-ctrl=saturation=32 \
	--set-ctrl=sharpness=24 \
	--set-ctrl=backlight_compensation=1 \
	--set-ctrl=auto_exposure=1 \
	-p 30 \
