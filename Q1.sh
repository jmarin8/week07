#!/bin/sh
FILES=from/*
mkdir to
for f in $FILES
do
  echo "Processing $f file..."
  cat $f
  mv $f to/
  # take action on each file. $f store current file name
done
