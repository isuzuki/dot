#! /bin/bash

# npmがインストールされていない場合は終了
if test ! "$(which npm)"; then
	echo "Not Installed npm..."
	exit 1
fi

npm install -g bower browser-sync gulp-cli karma-cli typescript yo
