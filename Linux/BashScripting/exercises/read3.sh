#!/usr/bin/env bash
COUNT=1

while IFS='' read -r LINE
do
    echo "Line $COUNT: $LINE"
    ((COUNT++))

    if [ $COUNT -ge 4 ]
    then
        break
    fi
done < "$1"

exit 0
