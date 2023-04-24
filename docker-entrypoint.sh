#!/bin/sh

if [[ -z ${SHARES} ]]; then
    if [[ ! -z ${SHARE_FILE} ]]; then
        SHARES="$(cat "${SHARE_FILE}")"
    fi
fi

gomplate -d "shares=env:///SHARES?type=application/yaml" --file /etc/samba/smb.conf.tmpl --out /etc/samba/smb.conf

exec /usr/sbin/smbd --interactive
