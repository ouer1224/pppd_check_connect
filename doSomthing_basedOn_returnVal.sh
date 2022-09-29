#!/bin/zsh

######
# do something base on the result of module power on
# if ok , return 0
# if err, return 1
######

print "do something base on the result of module power on adn pppd connect"
true=0
false=1
###################

state_module=$false
for i ({1..3})
{
    zsh module_check_on.sh
    res=$?
    if [[ $res == $true ]]
    then 
        echo "module ok"
        state_module=$true
        break;
    else
        echo "module err, repower it"
    fi
}

if [[ $state_module == $false ]]
then 
    echo "LTE module failed, exit later"
    exit $false
else
    echo "ready to call pppd"
fi


######

state_pppd=$false



for i ({1..3})
{

# call pppd

# check pppd state

zsh ppp_check_on.sh

res=$?


if [[ $res == $true ]]
then 
    ehco "stop loop"
    state_pppd=$true
    break;
else
    echo "continue loop"
fi

}


if [[ $state_pppd == $true ]]
then
    echo "pppd connect success"
    exit $true
else
    echo "pppd connect faile"
    exit $false
fi




