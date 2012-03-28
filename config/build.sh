#!/bin/sh

CSS='global.css'
JS="global.js"
echo "==========RESET PERMISSIONS============"
chmod -R 777 ./





echo "==========CLEAR OUT BUILD FOLDER============"
rm -R ./build/*

for URL in `find . -name "*.php" -depth 1`; do
		echo "Downloading $URL"
		fullURL=${URL:2:${#URL}}
		noExtensionURL=${URL:2:${#URL}-6}
		wget http://3pp.local/$fullURL -O./build/$noExtensionURL.html.tmp
		echo "Search and Replace for $URL..."
		sed -e 's/.php/.html/g' -e '/<link/d' -e '/defer/d' -e "s/<!--GLOBAL JS FILE GOES HERE (PRODUCTION)-->/<script defer src=\"js\/$JS\"><\/script>/g" -e "s/<!--GLOBAL CSS FILE GOES HERE (PRODUCTION)-->/<link href=\"css\/$CSS\" rel=\"stylesheet\">/g" ./build/$noExtensionURL.html.tmp > ./build/$noExtensionURL.html
		#tidy -config ./config/HTML_TIDY ./build/$noExtensionURL.html.tidy > ./build/$noExtensionURL.html
		rm ./build/$noExtensionURL.html.tmp
done






echo "==========BEGIN CSS MINIFICATION============"

mkdir ./build/css

echo "First add the base (with reset) -> global, then append the rest"
cat ./css/base.css >> ./build/css/$CSS.tmp
cat ./css/global.css >> ./build/css/$CSS.tmp

mv ./css/base.css ./css/base.bak
mv ./css/global.css ./css/global.bak
mv ./css/plugins/colorbox.css ./css/plugins/colorbox.bak

for URL in `find ./css -name "*.css"`; do
	echo "merging $URL"
	cat $URL >> ./build/css/$CSS.tmp
done

mv ./css/base.bak ./css/base.css
mv ./css/global.bak ./css/global.css

csstidy ./build/css/$CSS.tmp --preserve_css=true --remove_bslash=false ./build/css/$CSS

mv ./css/plugins/colorbox.bak ./css/plugins/colorbox.css
cat ./css/plugins/colorbox.css >> ./build/css/$CSS

rm ./build/css/*.css.tmp
echo "==========END CSS MINIFICATION============"






echo "==========BEGIN JS MINIFICATION============"
mkdir ./build/js
for URL in `find ./js -depth 1`; do
	echo "merging $URL"
	cat $URL >> ./build/$JS.tmp
done
java -jar ./config/yui/build/yui.jar --type js --line-break 100 ./build/$JS.tmp > ./build/js/$JS
rm ./build/*.js.tmp
cp -R ./js/plugins ./build/js/plugins
echo "==========END JS MINIFICATION============"





echo "==========MOVE OTHER ASSETS============"
cp -R ./img ./build
cp -R ./overlays ./build
sed 's/.php/.html/g' ./build/overlays/product.html > ./build/overlays/product.html.tmp
mv ./build/overlays/product.html.tmp ./build/overlays/product.html
chmod -R 777 ./
echo "DONE...lets SSH IN"

# mv ./build ./3pp
# scp -r ./3pp/ saldrich@proto.hugeinc.com:/home/saldrich/
# mv ./3pp ./build

echo "==========ZIP IT UP!============"
zip -r 3PP.zip ./build/

#find - gets just the file names
#grep - goes through the files itself and returns whatever you're looking for
#sed - 	goes through the files and does the text adjustments