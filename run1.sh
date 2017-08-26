#!/bin/sh

if [ "$1" == "" ]; then echo "No arguments"; return; fi
if [ $# -lt 5 ]; then echo "Should be 5 argumens"; return; fi

# ================================================================
GITHUB=$1
WS_DIR=$2
REPO=$3
VERSION=$4
MAIN_CLASS=$5
# ================================================================

if ! which java >/dev/null/ 2>&1; then java -version&>jv.txt; grep "java version" jv.txt; else echo Java not installed; return; fi
if ! which mvn >/dev/null/ 2>&1; then mvn -version&> mv.txt; grep "Apache Maven" mv.txt; else echo Maven not installed; return; fi
if ! which git >/dev/null/ 2>&1; then git -version&> gv.txt; grep "git version" gv.txt; else echo Git not installed; return; fi

if [ -d "$HOME/$WS_DIR/" ]; then cd ~/$WS_DIR; else echo $WS_DIR is not exist; return; fi
if [ -d "$HOME/$WS_DIR/$REPO" ]; then rm -rf $HOME/$WS_DIR/$REPO; fi

git clone https://github.com/$GITHUB/$REPO.git
cd ./$REPO

mvn package
echo executing Java program.............................
java -cp $HOME/$WS_DIR/$REPO/target/$REPO-$VERSION-jar-with-dependencies.jar $MAIN_CLASS
