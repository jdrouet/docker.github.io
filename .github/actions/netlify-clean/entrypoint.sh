#!/bin/sh

set -xe

echo "searching site ${NETLIFY_SITE_NAME}"

SITE_ID=$(netlify sites:list --json | jq --raw-output ".[] | select(.name==\"${NETLIFY_SITE_NAME}\") | .id")

echo "deleting site"

netlify sites:delete --force "${SITE_ID}"
