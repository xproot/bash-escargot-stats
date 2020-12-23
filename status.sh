#/bin/bash

# Escargot status for bash script made by
# xpuser/tlwxpuser/thatxpuser/xproot :D

# Set starting variables
timeout=15
timeoutms0=15000
timeoutms=14999

# If bash $0=status.sh $1 is not blank then
if [ ! "$1" == "" ]; then
 # then if $1 = --timeout then
 if [ "$1" == "--timeout" ]; then
  # then if $2 = a number then
  if [[ $2 =~ ^[0-9]+$ ]]; then
   # if $3 doesn't equal nothing then
   if [ ! "$3" == "" ]; then
    # display error message
    echo "Invalid option or parameter '$3'"
    echo "Usage: bash status.sh [--timeout seconds]"
    echo "--timeout changes the seconds until the script times out and"
    echo "assumes escargot is down."
    exit 1
   fi
   # if characters in $2 is greater than 6
   if [ "${#2}" -gt "6" ]; then
    # display error message with no help
    echo "Timeout value is too big! make it smaller before using this script again."
    exit 1
   fi
   # set overridding variables
   ms000="000"
   timeout="$2"
   timeoutms0="$timeout$ms000"
   timeoutms=`expr $timeoutms0 - 1`
   # if false then display help
  else
   echo "Usage: bash status.sh [--timeout seconds]"
   echo "--timeout changes the seconds until the script times out and"
   echo "assumes escargot is down."
   exit 1
  fi
 # if false then display help
 else
  echo "Usage: bash status.sh [--timeout seconds]"
  echo "--timeout changes the seconds until the script times out and"
  echo "assumes escargot is down."
  exit 1
 fi
fi

# tell the user the script is actually running.
echo "Working..."

# Calculating the epoch s and ns to ms i believe and making it start var
start=`echo $(($(date +%s%N)/1000000))`

# Netcat to escargot and wait for response
output=`echo 'VER 1 XP' | nc -w $timeout m1.escargot.log1p.xyz 1863`

# Calculating the epoch s and ns to ms i believe and making it end var
end=`echo $(($(date +%s%N)/1000000))`

# calculaling the time taken substracting new epoch from old epoch
ms=$((end-start))

# if's to check if its congested or not

# we start putting online
status="Online :D"

# if its more than 4999ms then its congested
if [ "$ms" -gt 4999 ]; then
 status="Congested :/"
fi

# if its more than 14999ms(normally unless set) then its offline (nc will timeout around now)
# also sets the time to 15000ms(normally unless set) removing the execution time (i should make it remove the execution time for more exact time)
if [ "$ms" -gt "$timeoutms" ]; then
 status="Offline :("
 ms="$timeoutms0"
fi

# checking how many characters are in the ms var
grep=`grep -o "[1|2|3|4|5|6|7|8|9|0]" <<<"$ms" | wc -l`

# case for splicing
timetaken="If this shows up, tell the creator something is wrong."

case $grep in
     4)
	  # X seconds, XXX ms.
	  splits=${ms:0:1}
	  splitm=${ms:1:4}
          timetaken="$splits second(s), $splitm ms"
          ;;
     5)
	  # XX seconds, XXXms.
          splits=${ms:0:2}
          splitm=${ms:2:4}
          timetaken="$splits seconds, $splitm ms"
          ;;
     6)
          # XXX seconds, XXXms.
          splits=${ms:0:3}
          splitm=${ms:3:5}
          timetaken="$splits seconds, $splitm ms"
          ;;
     7)
          # XXXX seconds, XXXms.
          splits=${ms:0:4}
          splitm=${ms:4:6}
          timetaken="$splits seconds, $splitm ms"
          ;;
     *)
	  # anything else is *ms.
          timetaken="$ms ms"
          ;;
esac

# finally output what we know

echo "=============ESCARGOT STATUS============="
echo "Is: $status"
echo "Time taken: $timetaken."
echo "=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/="

# info
echo "Accepted normal server response times are"
echo "5 seconds or less, server is considered"
echo "offline when it surpasses $timeout seconds."
echo "========================================="
