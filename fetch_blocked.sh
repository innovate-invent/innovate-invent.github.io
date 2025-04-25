#!/usr/bin/env bash

BLUESKY_HANDLE="did:plc:gdfkbwgnydyn4xgea7e7e6ht"
BLUESKY_PASSWORD="$(gopass show -o bluesky_app_password)" #"${BLUESKY_PASSWORD?"must be set"}"
PDSHOST="https://agrocybe.us-west.host.bsky.network"

ACCESS_JWT="$(curl -L -X POST "$PDSHOST/xrpc/com.atproto.server.createSession" \
    -H "Content-Type: application/json" \
    -d '{"identifier": "'"$BLUESKY_HANDLE"'", "password": "'"$BLUESKY_PASSWORD"'"}' | jq -r '.accessJwt')"
(
cursor=''
while resp="$(curl "$PDSHOST/xrpc/app.bsky.graph.getBlocks?limit=100&cursor=$cursor" \
    -H "Authorization: Bearer $ACCESS_JWT" \
    -H "Accepts: application/json")"; do
    jq -e '[.blocks[].did]' <<<"$resp" || break
    cursor="$(jq -er '.cursor' <<<"$resp")" && sleep 2 || break
done
cursor=''
while resp="$(curl "$PDSHOST/xrpc/app.bsky.graph.getMutes?limit=100&cursor=$cursor" \
    -H "Authorization: Bearer $ACCESS_JWT" \
    -H "Accepts: application/json")"; do
    jq -e '[.mutes[].did]' <<<"$resp" || break
    cursor="$(jq -er '.cursor' <<<"$resp")" && sleep 2 || break
done
) | jq --slurp 'flatten' > assets/blocked_commenters.json

git add assets/blocked_commenters.json
git commit -m"Update block list"