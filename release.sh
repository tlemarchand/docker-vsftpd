#!/bin/bash
git checkout main
podman run debian:bookworm-slim /bin/bash -c "apt-get update > /dev/null && apt-cache policy vsftpd | sed -n -e 's/^.*Candidate: //p' | tr -d '\n'" > version
git add -A
git commit -m "Version update"
git push origin main
git tag -f `cat version`
git push origin -f `cat version`
