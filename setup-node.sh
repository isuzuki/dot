#! /bin/bash

# npmがインストールされていない場合は終了
if test ! "$(which npm)"; then
	echo "Not Installed npm..."
	exit 1
fi

npm install -g gulp-cli bower yo
