#/bin/bash

# Script that gets the stats of Escargot
# made by xpuser/tlwxpuer/thatxpuser/xproot :P

# Get the 404 webpage from escargot and make it a variable
curl=`curl https://escargot.log1p.xyz/404 --stderr /dev/null`

# Split(?) to where the numbers are located
onlin1=${curl:798:10}

# Replaces curl variable to nothing to save resources?
curl=""

# Since our split is garbage right now, we get the numbers and make them into a variable
online=`echo "${onlin1//[!0-9]/}"`

#Finally output what we know with echo
echo "=========Escargot stats========="
echo "There are $online users online."
echo "-more coming soon-"
echo "================================"
