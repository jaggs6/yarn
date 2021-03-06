#!/bin/bash

set -ex

yarn version --new-version minor
VERSION=$(node -p -e "require('./package.json').version")
BRANCH=$(echo "$VERSION" | (IFS="."; read a b c && echo $a.$b-stable))
echo "$BRANCH"
git checkout -b "$BRANCH"
git push origin "$BRANCH" --follow-tags
git checkout master
yarn version --new-version preminor
git push origin master --follow-tags
