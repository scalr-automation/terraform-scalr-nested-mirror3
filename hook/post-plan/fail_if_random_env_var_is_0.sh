#!/bin/bash

set -e  # Exit on error

# Check if ALLOW_RUN is set
if [[ -z "$ALLOW_RUN" ]]; then
    echo "Error: ALLOW_RUN is not set."
    exit 1
fi

# Fail if ALLOW_RUN is 0
if [[ "$ALLOW_RUN" -eq 0 ]]; then
    echo "Error: ALLOW_RUN is set to 0. Exiting."
    exit 1
fi

echo "ALLOW_RUN is set to $ALLOW_RUN. Proceeding."