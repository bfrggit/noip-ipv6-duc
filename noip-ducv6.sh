#!/usr/bin/env bash

interface='INTERFACE' # e.g. enp3s0
user='EMAIL'
pass='PASSWORD'
hostname='HOSTNAME'

url='https://dynupdate.no-ip.com/nic/update'
agent='Personal noip-ducv6/linux-v1.0'

addrv4='0.0.0.0'
lastaddr='::'

update_ip () {
    addr=$(ip -6 addr show dev "${interface}" | sed -e'/inet6/,/scope global/s/^.*inet6 \([^ ]*\)\/.*scope global.*$/\1/;t;d')
    if [[ -z ${addr} ]]; then
        :
    elif [[ ${lastaddr} != ${addr} ]]; then
        echo "updating to ${addr}"
        out=$(curl --get --silent --show-error --user-agent "${agent}" --user "${user}:${pass}" -d "hostname=${hostname}" -d "myip=${addrv4}" -d "myipv6=${addr}" ${url})

        echo ${out}

        if [[ -z ${out} ]]; then
            :
        elif [[ ${out} == nochg* ]] || [[ ${out} == good* ]]; then
            lastaddr=${addr}
            sleep 3m
        elif [[ ${out} == 911 ]]; then
            echo "911 response, waiting 30 minutes"
            sleep 28m
        else
            exit 1
        fi
    fi
}

update_ip
while sleep 2m; do
    update_ip
done
