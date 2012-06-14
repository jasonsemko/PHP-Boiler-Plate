#!/usr/bin/perl -w

use strict;
use warnings;
use Switch;

#Variables
my $choice;

my $global_permissions = "755";
my $global_assets = "img overlays";
my $global_build_folder = "build2";
my $global_web_address = "http://sigmachina.local/";
my $global_tidy = 1;

my $css_min_name = "global.min.css";
my $css_order = "base global";

my $js_min_name = "global.min.js";

my $zip_name = "Project";
my $zip_append_timestamp = 1;

my $server_user = "jason";
my $server_port = "1124";
my $server_server = "50.56.114.19";
my $server_dest = "/home/jason/build";

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
		transfer_php();
		transfer_css();
		transfer_js();
		move_assets();
		zip();
		#for testing no need to continually deploy to server, this works
		deploy();
	
	} else {exit}
}


#Reset permissions so Perl can execute on certain files (precautionary)
sub reset_permissions {
	proclaim("RESET PERMISSIONS");
	system("chmod -R $global_permissions ./");
}

#Clear out our old build folder
sub clear_old_build {
	
	proclaim("CLEAR OUT BUILD FOLDER");
	
	system("rm -R ./$global_build_folder/* > /dev/null 2>&1");
	
	#If the build folder does not exist or the name changes, we need to create it!
	if($? != 0) {
		system("mkdir ./$global_build_folder/");
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
		
		system("wget $global_web_address$full_URL -O./$global_build_folder/$no_extension_URL.html");
		
		#replace all .php links with .html
		`sed -i ./$global_build_folder/$no_extension_URL.html 's/.php/.html/g' ./$global_build_folder/$no_extension_URL.html`;
		
		#remove all css and deferred javascript tags (replace with global)
		`sed -i ./$global_build_folder/$no_extension_URL.html '/<link/d' -e '/defer/d' ./$global_build_folder/$no_extension_URL.html`;
		
		#Insert global JS in appropriate place
		`sed -i ./$global_build_folder/$no_extension_URL.html 's#<!--GLOBAL JS FILE GOES HERE (PRODUCTION)-->#<script defer src="js/$js_min_name"></script>#g' ./$global_build_folder/$no_extension_URL.html`;
		
		#Insert global CSS in apprpriate place
		`sed -i ./$global_build_folder/$no_extension_URL.html 's#<!--GLOBAL CSS FILE GOES HERE (PRODUCTION)-->#<link href="css/$css_min_name" rel="stylesheet">#g' ./$global_build_folder/$no_extension_URL.html`;

		#Tidy up HTML?
		if($global_tidy) {
			`tidy -m -config ./config/HTML_TIDY $global_build_folder/$no_extension_URL.html`;
		}
	}
}


sub transfer_css {
	
	proclaim("BEGIN CSS MINIFICATION");
	
	#Make the css directory
	system("mkdir ./$global_build_folder/css");
	
	#put the starting css files (reset, base) into an array, go through and append to new global css file
	#After that change extension to .bak so in next css sweep they are not re-added to global css file
	my @css_beginners = split(/\s/, $css_order);
	foreach(@css_beginners) {
		`echo "\n\n/****************$_*****************/\n\n" >> ./$global_build_folder/css/$css_min_name.tmp`;
		system("cat ./css/$_.css >> ./$global_build_folder/css/$css_min_name.tmp");
		system("mv ./css/$_.css ./css/$_.bak");
	}
	system("mv ./css/plugins/colorbox.css ./css/plugins/colorbox.bak");
	
	#Previous css files are .bak now, left over css files can go in any order, add them to global alphabetically
	my @css_files = split(/\s/, `find ./css -name "*.css"`);
	foreach(@css_files) {
		`echo "\n\n/****************$_*****************/\n\n" >> ./$global_build_folder/css/$css_min_name.tmp`;
		system("cat $_ >> ./$global_build_folder/css/$css_min_name.tmp");
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
		#system("csstidy ./$global_build_folder/css/$css_min_name.tmp --preserve_css=true --remove_bslash=false ./$global_build_folder/css/$css_min_name.tmp");	
	}

	#move colorbox.bak to colorbox.css and append it to global (need to find better way to do this, use folder)
	system("mv ./css/plugins/colorbox.bak ./css/plugins/colorbox.css");
	system("cat ./css/plugins/colorbox.css >> ./$global_build_folder/css/$css_min_name.tmp");
	
	#move global.tmp to global.css, done
	system("mv ./$global_build_folder/css/$css_min_name.tmp ./$global_build_folder/css/$css_min_name");
	
	proclaim("END CSS MINIFICATION");
}

sub transfer_js {
	proclaim("BEGIN JS MINIFICATION");

	system("mkdir ./$global_build_folder/js");
	
	my @js_files = split(/\s/, `find ./js -name "*.js" -depth 1`);
	
	foreach(@js_files) {
		print "merging $_ \n";
		system("cat $_ >> ./$global_build_folder/js/$js_min_name.tmp");
	}
	
	system("java -jar ./config/yui/build/yui.jar --type js --line-break 100 ./$global_build_folder/js/$js_min_name.tmp > ./$global_build_folder/js/$js_min_name");
	
	#copy over all the js files in the plugins directory
	system("cp -R ./js/plugins ./$global_build_folder/js/plugins");
	
	proclaim("END JS MINIFICATION");
}

sub move_assets {
	proclaim("MOVE OTHER ASSETS");
	
	my @assets = split(/\s/, $global_assets);
	
	foreach(@assets) {
		system("cp -R ./$_ ./$global_build_folder");
	}
	
	system("sed -i ./$global_build_folder/overlays/product.html 's/.php/.html/g' ./$global_build_folder/overlays/product.html");
	
	system("chmod -R 755 ./");
}

sub zip {
	proclaim("ZIP IT UP");
	system("rm $zip_name");
	system("zip -r $zip_name ./$global_build_folder");
}

sub deploy {	
	system("rsync -rv --progress -e 'ssh -p $server_port' ./$global_build_folder $server_user\@$server_server:$server_dest");
}

sub proclaim{
	print "==========================$_[0]=============================\n";
}