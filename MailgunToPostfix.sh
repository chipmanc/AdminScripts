#!/bin/bash
curl -s --user api:${1} https://api.mailgun.net/v2/domains | \
egrep '(smtp_login|name|smtp_password)' | \
sed -e 'N;s/\n/ /' -e 'N;s/\n/ /' | \
awk '{print $4 $2 $6}' | \
sed -e 's@[",]@ @g' -e 's:^ :@:' | \
awk '{print $1 " "  $2 ":" $3}'

