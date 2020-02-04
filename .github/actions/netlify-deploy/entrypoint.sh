#!/bin/sh

set -xe

echo "creating site"

netlify sites:create \
  --account-slug ${NETLIFY_ACCOUNT_SLUG} \
  --manual \
  --name "${NETLIFY_SITE_NAME}"

echo "fetching site id"

SITE_LIST_JSON=$(netlify sites:list --json)
SITE_ID=$(echo $SITE_LIST_JSON | jq --raw-output ".[] | select(.name==\"${NETLIFY_SITE_NAME}\") | .id")
SITE_URL=$(echo $SITE_LIST_JSON | jq --raw-output ".[] | select(.name==\"${NETLIFY_SITE_NAME}\") | .url")

echo
echo "site id $SITE_ID"
echo "site url $SITE_URL"
echo ::set-output name=site_id::$SITE_ID
echo ::set-output name=site_url::$SITE_URL
echo

echo "deploy site"

netlify deploy --prod --dir ${NETLIFY_DIRECTORY} --site $SITE_ID