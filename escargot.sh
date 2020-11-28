#/bin/bash

#Escargot status for bash script made by
#xpuser/tlwxpuser/thatxpuser/xproot :D

#tell the user the script is actually running.
echo "Working..."

#Calculating the epoch s and ns to ms i believe and making it start var
start=`echo $(($(date +%s%N)/1000000))`

#Netcat to escargot and wait for response
output=`echo 'VER 1 XP' | nc -w 15 m1.escargot.log1p.xyz 1863`

#Calculating the epoch s and ns to ms i believe and making it end var
end=`echo $(($(date +%s%N)/1000000))`

#calculaling the time taken substracting new epoch from old epoch
ms=$((end-start))

#if's to check if its congested or not

#we start putting online
status="Online :D"

#if its more than 4999ms then its congested
if [ $ms -gt 4999 ]; then
 status="Congested :/"
fi

#if its more than 14999ms then its offline (nc will timeout around now)
if [ $ms -gt 14999 ]; then
 status="Offline :("
fi

#checking how many characters are in the ms var
grep=`grep -o "[1|2|3|4|5|6|7|8|9|0]" <<<"$ms" | wc -l`

#case for splicing
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
     *)
	  #anything else is *ms.
          timetaken="$ms ms"
          ;;
esac

#finally output what we know

echo "=============ESCARGOT STATUS============="
echo "Is: $status"
echo "Time taken: $timetaken."
echo "=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/=/="

#info
echo "Accepted normal server response times are"
echo "5 seconds or less, server is considered"
echo "offline when it surpasses 15 seconds."
echo "========================================="
