#!/usr/bin/env bash
#
# filer.sh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

BOX_DRIVE_COUNT=10
HOST_DRIVE_COUNT=12
#SHELF_DRIVE_COUNT=$(( HOST_DRIVE_COUNT * 5 ))

# In case any host isn't completely empty
EXTRA_DRIVE_COUNT=0


# echo "How many shelves are you working on?"
# read -r SHELF_AMOUNT

echo "How many hosts are you working on?"
read -r HOST_AMOUNT

echo "Any there any hosts that are partially complete? [y/n]"
read -r -n 1 ANSWER
case $ANSWER in
  y)
    echo
    echo "How many drives are currently in them?"
    read -r EXTRA_DRIVE_COUNT
    EXTRA_DRIVE_COUNT=$(( 12 - EXTRA_DRIVE_COUNT ))
    echo "EXTRA_DRIVE_COUNT = $EXTRA_DRIVE_COUNT"
    ;;
esac

DRIVES_NEEDED="$(( (HOST_DRIVE_COUNT * HOST_AMOUNT) + EXTRA_DRIVE_COUNT))"
BOXES_NEEDED="$(( DRIVES_NEEDED / BOX_DRIVE_COUNT ))"
REMAINDER="$(( DRIVES_NEEDED % BOX_DRIVE_COUNT ))"

# If we have a remainder, we add another box
if [[ $REMAINDER -gt 0 ]]; then
  ((BOXES_NEEDED=BOXES_NEEDED+1))
fi

echo "You need $DRIVES_NEEDED drives"
echo "Which is $BOXES_NEEDED boxes from the storeroom"
if [[ $REMAINDER -gt 0 ]]; then
  echo "You'll have $(( HOST_DRIVE_COUNT - REMAINDER )) drives left over"
fi
