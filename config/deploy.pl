#!/usr/bin/perl -w

use strict;
use warnings;
use Switch;

[GLOBAL]
perms = "755"
assets = "img overlays"
build_folder_name = "build2"
web_address = "http://sigmachina.local/"
tidy = true

[CSS]
min_name = "global.min.css"
order = "base global"

[JS]
min_name = "global.min.js"

[ZIP]
name = "Project"
append_timestamp = true

[SERVER]
user = "jason"
port = "1124"
server = "50.56.114.19"
dest = "/home/jason/build"

switch($ARGV[0]){
	
	case "zip" {zip();}
	case "test"{ziptest();}
	else{init();}
}


#Functions

#Begins the build after user is given a last chance prompt before hand
sub init {
	
	print "*********************************************************\n\n";
	print "***********You are about to deploy to $ARGV[0]***********\n\n";
	print "***********(C)ontinue         (E)xit*********************\n\n";
	print "*********************************************************\n\n";

	chomp($choice = <STDIN>);

	if($choice eq "C" || $choice eq "c") {
	
		reset_permissions();
		clear_old_build();
		#transfer_php();
		#transfer_css();
		transfer_js();
		#move_assets();
		#zip();
		#for testing no need to continually deploy to server, this works
		#deploy();
	
	} else {exit}
}


#Reset permissions so Perl can execute on certain files (precautionary)
sub reset_permissions {
	proclaim("RESET PERMISSIONS");
	system("chmod -R $Config->{'GLOBAL.perms'} ./");
}

#Clear out our old build folder
sub clear_old_build {
	
	proclaim("CLEAR OUT BUILD FOLDER");
	
	system("rm -R ./$BUILD/* > /dev/null 2>&1");
	
	#If the build folder does not exist or the name changes, we need to create it!
	if($? != 0) {
		system("mkdir ./$BUILD/");
	}
	
}

#Move all the PHP files over to the build
sub transfer_php {
	
	my @php_files = split(/\s/,`find . -name '*.php' -depth 1`);
	my $full_URL;
	my $no_extension_URL;
	
	foreach(@php_files){

		$full_URL = substr($_, 2);
		$no_extension_URL = substr($_, 2, -4);
		print "Downloading $full_URL \n";
		
		system("wget $Config->{'GLOBAL.web_address'}$full_URL -O./build/$no_extension_URL.html");
		
		#replace all .php links with .html
		`sed -i ./$BUILD/$no_extension_URL.html 's/.php/.html/g' ./$BUILD/$no_extension_URL.html`;
		
		#remove all css and deferred javascript tags (replace with global)
		`sed -i ./$BUILD/$no_extension_URL.html '/<link/d' -e '/defer/d' ./$BUILD/$no_extension_URL.html`;
		
		#Insert global JS in appropriate place
		`sed -i ./$BUILD/$no_extension_URL.html 's#<!--GLOBAL JS FILE GOES HERE (PRODUCTION)-->#<script defer src="js/$JS"></script>#g' ./$BUILD/$no_extension_URL.html`;
		
		#Insert global CSS in apprpriate place
		`sed -i ./$BUILD/$no_extension_URL.html 's#<!--GLOBAL CSS FILE GOES HERE (PRODUCTION)-->#<link href="css/$CSS" rel="stylesheet">#g' ./$BUILD/$no_extension_URL.html`;

		#Tidy up HTML?
		if($Config->{'GLOBAL.tidy'}) {
			`tidy -m -config ./config/HTML_TIDY $BUILD/$no_extension_URL.html`;
		}
	}
}


sub transfer_css {
	
	proclaim("BEGIN CSS MINIFICATION");
	
	#Make the css directory
	system("mkdir ./$BUILD/css");
	
	#put the starting css files (reset, base) into an array, go through and append to new global css file
	#After that change extension to .bak so in next css sweep they are not re-added to global css file
	my @css_beginners = split(/\s/, $Config->{"CSS.order"});
	foreach(@css_beginners) {
		`echo "\n\n/****************$_*****************/\n\n" >> ./$BUILD/css/$CSS.tmp`;
		system("cat ./css/$_.css >> ./$BUILD/css/$CSS.tmp");
		system("mv ./css/$_.css ./css/$_.bak");
	}
	system("mv ./css/plugins/colorbox.css ./css/plugins/colorbox.bak");
	
	#Previous css files are .bak now, left over css files can go in any order, add them to global alphabetically
	my @css_files = split(/\s/, `find ./css -name "*.css"`);
	foreach(@css_files) {
		`echo "\n\n/****************$_*****************/\n\n" >> ./$BUILD/css/$CSS.tmp`;
		system("cat $_ >> ./$BUILD/css/$CSS.tmp");
	}
	
	#Now that all css has been added to global, return from .bak to .css
	foreach(@css_beginners) {
			system("mv ./css/$_.bak ./css/$_.css");
	}

	#test out csstidy
	system("csstidy > /dev/null 2>&1");
	
	#Yes we have csstidy, use it
	if($? == 0) {
		#proclaim("CSS TIDY ME UP");
		#system("csstidy ./$BUILD/css/$CSS.tmp --preserve_css=true --remove_bslash=false ./$BUILD/css/$CSS.tmp");	
	}

	#move colorbox.bak to colorbox.css and append it to global (need to find better way to do this, use folder)
	system("mv ./css/plugins/colorbox.bak ./css/plugins/colorbox.css");
	system("cat ./css/plugins/colorbox.css >> ./$BUILD/css/$CSS.tmp");
	
	#move global.tmp to global.css, done
	system("mv ./$BUILD/css/$CSS.tmp ./$BUILD/css/$CSS");
	
	proclaim("END CSS MINIFICATION");
}

sub transfer_js {
	proclaim("BEGIN JS MINIFICATION");

	system("mkdir ./$BUILD/js");
	
	my @js_files = split(/\s/, `find ./js -name "*.js" -depth 1`);
	
	foreach(@js_files) {
		print "merging $_ \n";
		system("cat $_ >> ./$BUILD/$JS");
	}
	
	system("java -jar ./config/yui/build/yui.jar --type js --line-break 100 ./$BUILD/$JS > ./$BUILD/js/$JS");
	
	#copy over all the js files in the plugins directory
	system("cp -R ./js/plugins ./$BUILD/js/plugins");
	
	proclaim("END JS MINIFICATION");
}

sub move_assets {
	proclaim("MOVE OTHER ASSETS");
	
	my @assets = split(/\s/, $Config->{"GLOBAL.assets"});
	
	foreach(@assets) {
		system("cp -R ./$_ ./$BUILD");
	}
	
	system("sed -i ./$BUILD/overlays/product.html 's/.php/.html/g' ./$BUILD/overlays/product.html");
	
	system("chmod -R 755 ./");
}

sub zip {
	proclaim("ZIP IT UP");
	system("rm $Config->{'ZIP.name'}.zip");
	system("zip -r $Config->{'ZIP.name'}.zip ./$BUILD");
}

sub deploy {	
	system("rsync -rv --progress -e 'ssh -p $Config->{'SERVER.port'}' ./$BUILD $Config->{'SERVER.user'}\@$Config->{'SERVER.server'}:$Config->{'SERVER.dest'}");
}

sub proclaim{
	print "==========================$_[0]=============================\n";
}


#With use of config.ini file, currently considering removing this for one less dependency

# #Perl Module that works with config.ini
# use Config::Simple;
# 
# #global vars
# my $choice;
# 
# #Create a global variable with all the configuration options
# my %Config;
# Config::Simple->import_from('config.ini', \%Config);
# my $cfg = new Config::Simple('./config/config.ini');
# my $Config = $cfg->vars();
# 
# #Globals used often throughout script
# my $CSS = $Config->{'CSS.min_name'};
# my $JS = $Config->{'JS.min_name'};
# my $BUILD = $Config->{'GLOBAL.build_folder_name'};