#!/bin/bash

echo $'\n' "------ CHECKING FOR CONFIGURATION KEYS! ----------------" $'\n'

if [ -z "$DEPLOY_KEY" ] 
then 
	echo $'\n' "------ DEPLOY KEY NOT SET YET! ----------------" $'\n'
	exit 1
fi

if [ -z "$DEPLOY_USER" ]; then
	echo $'\n' "------ DEPLOY_USER IS NOT SET YET! ----------------" $'\n'
	exit 1
fi

if [ -z "$DEPLOY_HOST" ]; then
	echo $'\n' "------ DEPLOY_HOST IS NOT SET YET! ----------------" $'\n'
	exit 1
fi

if [ -z "$DEPLOY_PATH" ]; then
	echo $'\n' "------ DEPLOY_PATH IS NOT SET YET! ----------------" $'\n'
	exit 1
fi

echo $'\n' "------ DEPLOYMENT KEYS CHECK COMPLETE ----------------" $'\n'


#update known hosts
mkdir -p /root/.ssh
ssh-keyscan -H "$DEPLOY_HOST" >>/root/.ssh/known_hosts

#deploy ssh key
printf '%b\n' "$DEPLOY_KEY" >/root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa

echo $'\n' "------ SSH KEY DEPLOYED SUCCESSFUL! ---------------------" $'\n'

#Test the connection
ssh -q -i /root/.ssh/id_rsa $DEPLOY_USER@$DEPLOY_HOST
if [ $? -eq 0 ]; then
	echo $'\n' "------ CONNECTION TEST SUCCESSFUL! -----------------------" $'\n'
else
	echo $'\n' "------ CONNECTION TEST FAILED! -----------------------" $'\n'
	exit 1
fi


#PULL
ssh -i /root/.ssh/id_rsa -t $DEPLOY_USER@$DEPLOY_HOST "cd $DEPLOY_PATH && git pull"
if [ $? -ne 0 ]; then
	echo $'\n' "------ UNABLE TO PULL CODE! -----------------------" $'\n'
	exit 1
fi
echo $'\n' "------ CODE PULLED! -----------------------" $'\n'

echo $'\n' "------ THE DEPLOYMENT WAS SUCCESSFUL!!! ---------" $'\n'


exit 0;