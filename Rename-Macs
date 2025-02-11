#!/bin/bash

#!/bin/bash

userName=$(/bin/ls -la /dev/console | /usr/bin/cut -d " " -f 4)
realName=$(/usr/bin/dscl . read /Users/$userName RealName | /usr/bin/sed '2p;d')
firstName=$(echo "${realName}" | /usr/bin/cut -d " " -f 2 | /usr/bin/tr '[:upper:]' '[:lower:]')
lastName=$(echo "${realName}" | /usr/bin/cut -d " " -f 3 | /usr/bin/tr '[:upper:]' '[:lower:]')
macModel=$(/usr/sbin/sysctl -n hw.model)

#  Need to define the non MacBooks options
if [ "$(/usr/sbin/sysctl -in hw.optional.arm64)" = 1 ] && /usr/sbin/sysctl -n machdep.cpu.brand_string | /usr/bin/grep -q 'Apple' && /usr/bin/uname -v | /usr/bin/grep -q 'ARM64'
then
 macModel="$(/usr/libexec/PlistBuddy -c 'print 0:product-name' /dev/stdin <<< "$(/usr/sbin/ioreg -ar -k product-name)")"
else 
 macModel=$(/usr/sbin/sysctl -n hw.model)
fi

if [[ "$macModel" =~ Air ]]; then
 setModel='MBA'
elif [[ "$macModel" =~ Pro ]]; then
 setModel='MBP'
else
 setModel='DS'
fi

computerName="$firstName.$lastName-$setModel"

#Setting ComputerName
scutil --set ComputerName $computername


#Setting HostName
scutil --set HostName $computername


#Setting LocalHostName
scutil --set LocalHostName $computername

#Flush the DNS cache  
dscacheutil –flushcache 
exit
