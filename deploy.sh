#!/bin/bash

echo "hello world"

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "gh-pages" ]
then 
    echo "This commit was made against the $TRAVIS_BRANCH and not the gh-pages. No deploy!" 
#    exit 0
fi

rev=$(git rev-parse --short HEAD)

cd _book

git init
git config user.name "ESbook"
git config user.email "book.eson.org@gmail.com"
git remote add upstream "https://$GH_TOKEN@github.com/ESbook/TCP-IP.git"
git fetch upstream && git reset upstream/gh-pages

echo "book.eson.org" > CNAME

echo "pushing to github"
git add -A .
git commit -m "rebuild pages at ${rev}"
git push --force --quiet upstream HEAD:gh-pages
