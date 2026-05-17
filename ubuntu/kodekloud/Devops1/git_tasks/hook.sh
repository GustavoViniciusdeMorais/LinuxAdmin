#!/bin/bash
for refname in "$@"; do
    if [ "$refname" = "refs/heads/master" ]; then
        today=$(date +%F)
        tag_name="release-${today}"

        newrev=$(git rev-parse "$refname")

        git tag -f "$tag_name" "$newrev"
    fi
done
# Standard post update behaviour so clients works
exec git update-server-info