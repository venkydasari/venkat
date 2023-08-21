#!/bin/bash
Date=$(date +%F)
logdir=/home/centos/shellscripts-logs
script_name=$0
logfile=$logdir/$0-$Date.log
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
if [ $USERID -ne 0 ];
then
echo -e "$R error::Please install with admin access $N";
exit 1
fi
VALIDATE(){
    if [$1 -ne 0];
    then
    echo -e " Installing $2 ...$R FAILUR $N";
    else
    echo -e " Installing $2 ...$G SUCCESS $N";
    fi
}
for i in $@

do
    yum list installed $i &>>$LOGFILE
    if [ $? -ne 0 ];
    then
        echo "$i is not installed, let's install it";
        yum install $i -y &>>$LOGFILE
        VALIDATE $? "$i"
    else
        echo -e "$Y $i is already installed $N";
    fi

    #yum install $i -y
done