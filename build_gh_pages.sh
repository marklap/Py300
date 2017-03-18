#!/bin/sh

# simple script to build and push to gh-pages
# designed to be run from master

# this version used a separate copy of the repo in a parallel dir
# to keep the gh-pages branch nicely separate from the main branch.

GHPAGESDIR=../Py300.gh-pages/

# make sure gh-pages dir is there -- exit if not
if [ ! -d $GHPAGESDIR ]; then
    echo "To build the gitHub pages, you must first create a parallel repo: $GHPAGESDIR"
    exit
fi

# make sure that the main branch is pushed, so that pages are in sync with master
git push

# make sure the gh pages repo is there and in the right branch
pushd $GHPAGESDIR
git checkout gh-pages
popd

# make the docs
make html
# copy to other repo (on the gh-pages branch)
cp -R build/html/ $GHPAGESDIR

pushd $GHPAGESDIR
git add . # in case there are new files added
git commit -a -m "updating presentation materials"
git pull -s ours --no-edit
git push
