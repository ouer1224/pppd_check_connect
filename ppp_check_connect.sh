#!/bin/zsh

######
# auto check the connection of ppp
# if ok , return 0
# if err, return 1
######

echo  "------------auto check the connection of ppp--------------"
true=0
false=1
###################

function single_check_ppp_connect()
{
    ping -4 -I ppp0 www.baidu.com -c 5
    lores=$?

    if [[ $lores == 0 ]]
    then
        echo "ppp connection is ok"
        return $true
    else
        echo "ppp connection is dropped"
        return $false
    fi

}

#######
# reconnect the ppp
function ppp_reconnect()
{
    killall pppd
    sleep 1
    pppd call myppp   # ppp拨号

    return $true;
}



######## 
# loop check connection

while [[ $true ]]
{
    single_check_ppp_connect
    res=$?
    if [[ $res == $true ]]
    then
        echo "state ok"
    else
        echo "state connection drop"

    fi

    sleep 30    # delay 30s

}









