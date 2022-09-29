#!/bin/zsh

######
# auto check lte module if power on ??
# if ok , return 0
# if err, return 1
######

echo  "------------auto check lte module if power on ??--------------"
true=0
false=1
###################

function check_mmodule_powerOn()
{
    #dev_list= $(ls /dev | grep ttyS28)
    dev_list=`ls /dev | grep ttyS28`

    echo "dev_list = $dev_list"

    res=$false
    [[ "$dev_list" != "" ]] && res=$true

    if [[ $res == $true ]]
    then
        echo "have got the dev"
        return $true
    else
        echo "no target is found"
        return $false
    fi
}


##########

state_poweron=$false

for i ({1..20})
{

    sleep 1

    check_mmodule_powerOn
    res=$?
    echo res=$res

    if [[ $res == $true ]]
    then
        echo "get the dev, stop loop"
        state_poweron=$true
        break;
    else
        echo "target is not found, continue to loop"
    fi

}


if [[ $state_poweron == $true ]]
then
    echo "module power OK"
    exit $true
else
    echo "module power err"
    exit $false
fi


