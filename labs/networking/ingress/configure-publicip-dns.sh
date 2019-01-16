#!/bin/bash

# Public IP address
IP="40.70.246.198"

# Name to associate with public IP address
DNSNAME=$UNIQUE_SUFFIX

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

# Update public ip address with dns name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME

# configure dns
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-out ~/kubernetes-hackfest/labs/networking/ingress/aks-ingress-tls.crt \
-keyout ~/kubernetes-hackfest/labs/networking/ingress/aks-ingress-tls.key \
-subj "/CN=thapham1404.eastus2.cloudapp.azure.com/O=aks-ingress-tls"
