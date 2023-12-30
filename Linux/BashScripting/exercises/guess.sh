#!/usr/bin/env bash
COMPUTER=17
VALID=0

while [ $VALID -eq 0 ]
do
    read -p "Guess a number between 0 and 50: " GUESS

    if [ $GUESS -gt $COMPUTER ]
    then
        echo "Too high, try again"
        continue
    elif [ $GUESS -lt $COMPUTER ]
    then
        echo "Too low, try again"
        continue
    fi
    VALID=1
done

echo "You guessed it!"
exit 0
