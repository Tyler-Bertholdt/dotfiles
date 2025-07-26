#!/bin/bash

PID=$(pgrep -x gammastep)

if [ -n "$PID" ]; then
    kill "$PID"  
else
    gammastep  4500 &  
fi
