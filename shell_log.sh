#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
B="\e[34m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript_logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
USER=$(logname)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP-$USER.log"
FUNCTION(){
    if [ $1 -ne 0 ]
         then
           echo -e "$2....$R Failure"$N
           exit 1
        else
            echo -e "$2.....$G Success"$N
       fi   
}

if [ $USERID -ne 0 ]
then
echo "Error: you're not sudo mode, get sudo access and proceed"
exit 1
fi
echo "$TIMESTAMP"
dnf list installed mysql &>>$LOG_FILE_NAME
 if [ $? -ne 0 ]    # "echo $? ---> code for last command is success,
                    # if success showing 0, if unsuccess showing any number
    then
       dnf install mysql -y
        FUNCTION $? "Installation MYSQL"
    else
       echo -e $B"Mysql Already installed"$N
  fi
dnf list installed git &>>$LOG_FILE_NAME
  if [ $? -ne 0 ]
    then
       dnf install git -y
       FUNCTION $? "Installation git"
     else
        echo -e $B"git already installed"$N
    fi
dnf list installed nginx &>>$LOG_FILE_NAME
    if [ $? -ne 0 ]
    then
    dnf install nginx -y
      FUNCTION $? "Installation nginx"
     else
     echo -e $B"nginx already installed"$N
    fi

