#!/bin/bash

date=$(date "+%m/%d/%y %H:%M:%S")
userID=$(id -u)
rootID=0
owner=$(logname)
outputFile="output.txt"
absolutePath=$(readlink -f $outputFile)

#display help if needed
if [ "$1" == "-help" ]
then
    echo "$0 -help : displays help"
    echo "$0 (no args) : track all file changes in the system since the program started"
    echo "$0 \"m/d/y H:M:S\" : will track all file changes in the system since the outputed date"
    exit
fi

#check if SU
if [ "$userID" != "$rootID" ]
then
    echo "Please run this script as root"
    exit
fi

#check if output file exists and give user the ownership
if [[ ! -f "$outputFile" ]]
then
    touch "$outputFile"
    chown "$owner" "$outputFile"
    chgrp "$owner" "$outputFile"
fi

if [ "$1" == "" ]
#no date was given in args
then
    echo "Tracking all files that changed since $date."
    find / . -type f -newermt "$date" 2>/dev/null | grep -vE "/proc/|\./output.txt|$absolutePath" > "$outputFile"
    echo "Result written in output.txt."
    exit
#date was given in args
else
    date "+%m/%d/%y %H:%M:%S" -d "$1" > /dev/null  2>&1
    isValid=$? #check if format is valid
    if [ $isValid == 0 ]
    then
        echo "Tracking all files that changed since $1."
        find / . -type f -newermt "$1" 2>/dev/null | grep -vE "/proc/|\./output.txt|$absolutePath" > "$outputFile"
        echo "Result written in output.txt."
        exit
    else
        echo "Date format incorrect, must be in \"m/d/y H:M:S\" format."
        exit
    fi
fi