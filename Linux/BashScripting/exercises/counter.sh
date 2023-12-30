#!/usr/bin/env bash
TARGET=$1
COUNT=1

while [ $COUNT -le $TARGET ]
do
    echo "Count = $COUNT"
    ((COUNT++))
done

echo "Loop Finished"
exit 0
