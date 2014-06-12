#!/bin/bash

echo "Add rabbitmq user"
rabbitmqctl add_user {{ mq.rabbit.user }} {{ mq.rabbit.passwd }}
if [ $? -ne 0 ]
then
    echo "Change password of rabbitmq user"
    rabbitmqctl change_password {{ mq.rabbit.user }} {{ mq.rabbit.passwd }}
fi

if [ $? -eq 0 ]
then
    echo "Successfully set rabbitmq."
else
    echo "Failed to set rabbitmq."
fi
