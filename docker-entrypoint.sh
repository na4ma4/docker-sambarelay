#!/bin/bash

set -o nounset

if [[ -z ${SHARES} ]]; then
    if [[ ! -z ${SHARE_FILE} ]]; then
        SHARES="$(cat "${SHARE_FILE}")"
    fi
fi

gomplate -d "shares=env:///SHARES?type=application/yaml" --file /etc/samba/smb.conf.tmpl --out /etc/samba/smb.conf

ionice -c 3 /usr/sbin/nmbd -D

exec ionice -c 3 /usr/sbin/smbd -FS --no-process-group
