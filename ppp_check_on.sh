#!/bin/zsh

######
# auto check pppd if dial up ok or err
# if ok , return 0
# if err, return 1
######

print "auto check pppd if dial up ok or err"
true=0
false=1
###################

function check_the_task()
{
    res=$(ps | grep pppd)
    ifres=$(ifconfig | grep pppd)

    # if ifconfig has no pppd, then the pppd is not ready
    [[ "$res" == "" ]] && [[ "$ifres" == "" ]] && errcode=$false

    if [[ $errcode == $true ]]
    then
    echo true
    echo "res get the result = $res"
    return $true;
    else
    echo false
    echo "res has no result = $res"
    return $false;
    fi   
}


pppd_powerOn_ok=$false

for i ({1..20})
{
    echo    i=$i
    sleep 1   # sleep to check
    check_the_task
    res=$?
    echo "exitcode=$res"
    if [[ $res == $false ]]
    then 
        echo "continue check"
    else   
        echo "get it , stop"
        pppd_powerOn_ok=$true
        break;
    fi
}

echo i=$i

if [[ $pppd_powerOn_ok == $true ]]
then
    echo "pppd power on success"
    exit $true
else
    echo "pppd power on failed"
    exit $false
fi



