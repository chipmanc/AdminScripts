#!/bin/bash
mail=0
for x in `ls /var/spool/postfix/deferred`
do  
let mail+=`ls /var/spool/postfix/deferred/${x} -l|wc -l`
done
echo "$mail"
