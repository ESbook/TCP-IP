#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "gh-pages" ]
then 
    echo "This commit was made against the $TRAVIS_BRANCH and not the gh-pages. No deploy!" 
    exit 0
fi

rev=$(git rev-parse --short HEAD)

cd _book

git initgit config user.name "esbook"

git config user.email "book.eson.org@gmail.com"

git remote add upstream "https://$GH_TOKEN@github.com/ESbook/TCP-IP.git"

echo "book.eson.org" > CNAME

git add -A

git commit -m "rebuild pages at ${rev}"

git push -f upstream HEAD:gh-pages
