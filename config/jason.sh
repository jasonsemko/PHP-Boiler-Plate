#!/bin/sh
echo "==========RESET PERMISSIONS============"
chmod -R 777 ./

echo "==========CLEAR OUT BUILD FOLDER============"
rm -R ./build/*

for URL in `find . -name "*.php" -depth 1`; do
		echo "Downloading $URL"
		jason=${URL:2:${#URL}}
		liza=${URL:2:${#URL}-6}
		wget http://3pp.local/$jason -O./build/$liza.html
		#tidy -config ./config/HTML_TIDY ./build/$liza.html.tmp > ./build/$liza.html
		#rm ./build/$liza.html.tmp
done

echo "==========BEGIN CSS MINIFICATION============"
mkdir ./build/css
for URL in `find ./css -name "*.css"`; do
	echo "merging $URL"
	cat $URL >> ./build/super.css.tmp
done
java -jar ./config/yui/build/yui.jar --type css --line-break 100 ./build/super.css.tmp > ./build/css/super.css
rm ./build/*.css.tmp
echo "==========END CSS MINIFICATION============"






echo "==========BEGIN JS MINIFICATION============"
mkdir ./build/js
for URL in `find ./js -depth 1`; do
	echo "merging $URL"
	cat $URL >> ./build/super.js.tmp
done
java -jar ./config/yui/build/yui.jar --type js --line-break 100 ./build/super.js.tmp > ./build/js/super.js
rm ./build/*.js.tmp
cp -R ./js/plugins ./build/js/plugins
echo "==========END JS MINIFICATION============"






echo "==========MOVE OTHER ASSETS============"
cp -R ./img ./build
cp -R ./overlays ./build
echo "DONE"

#find - gets just the file names
#grep - goes through the files itself and returns whatever you're looking for
#sed - 	goes through the files and does the text adjustments