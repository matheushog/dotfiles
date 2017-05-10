#/bin/bash

#### dependencies:
# 1) feh --> background
# 2) alsamix --> audio infos
# 3) acpitool --> battery infos
# 4) ifconfig --> networkinfos

#### infos:
# 1) updates all 0.5 seconds 
#		--> volume and battery state in the statusbar updates only all 0.5 seconds --> easy editable
#		--> update time is not in syc with the system time --> seconds display may look laggy
# 2) network is looking for the strings 'eth0' and 'wlan0' --> easy editable

while true
do
   battery=$(acpi -b | cut -d"," -f2 | cut -d" " -f2)
   wifi=$(iwgetid -r)
#   ip=$(ifconfig wlp3s0| grep "inet A"|cut -d: -f2 | cut -d" " -f 1)
#   ip="wlp3s0:${ip}"
   vol=$(amixer get Master | egrep "^  Front Left"| cut -d"[" -f 2 | cut -d"%" -f 1)
   vol="${vol}%"
#   mute=$(amixer get Master | egrep "^  Front Left"| cut -d"[" -f 4 | cut -d"]" -f 1)
#   tmp="wlp3s0:"
#   if [ "$ip" = "$tmp" ]
#	then
#   	ip=$(ifconfig wlp3s0| grep "inet A"|cut -d: -f2 | cut -d" " -f 1)
#	ip="wlp3s0:${ip}"
#   fi
#   tmp="off"
#   if [ "$mute" = "$tmp" ]
#	then
#	vol="mute"
#   fi
  temp=$(head -c 2 /sys/class/hwmon/hwmon1/temp1_input)
  date=$(date +"%a %d %b")
  clock=$(date +"%H:%M:%S")

   xsetroot -name " :$vol :$battery :$wifi :$tempºC  $date  $clock "
   sleep 1    # Update time
done &
