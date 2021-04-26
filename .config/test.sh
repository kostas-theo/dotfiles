#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    # Do something on Mac OS X platforms
    echo "I am a mac"
elif [ "$(uname)" == "Linux" ]; then
    # Do something on Linux platforms
    echo "I am a penguin"
fi
