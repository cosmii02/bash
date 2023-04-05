#!/bin/bash

# serverite IP-aadressid
server1="10.17.142.109"
server2="10.17.141.213"
server3="10.17.141.225"

# loop serverite üle ja kontrolli, kas nad on võrgus
for server in $server1 $server2 $server3
do
    # Pingi serverit ja väldi pingimise tulemuse kuvamist ekraanile
    ping -c 1 $server > /dev/null 2>&1
    
    # Kontrolli pingi õnnestumist
    if [ $? -eq 0 ]; then
        echo -e "\e[32mServer $server on võrgus kättesaadav\e[0m"
        
        # Kontrolli serveri tööaega
        uptime=$(ssh cosmiitest@$server "uptime -s")
        echo -e "Server on töös olnud alates: \e[34m$uptime\e[0m"
    else
        echo -e "\e[31mServer $server pole võrgus kättesaadav\e[0m"
        
        # Salvesta serveri IP, kuupäev ja kellaaeg faili serverid.txt
        echo -e "\e[31m$(date '+%Y-%m-%d %H:%M:%S') $server\e[0m" >> serverid.txt
    fi
done
