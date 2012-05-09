#!/usr/bin/perl -w

use strict;
use warnings;
use Switch;

#Perl Module that works with config.ini
use Config::Simple;

#global vars
my $choice;

#Create a global variable with all the configuration options
my %Config;
Config::Simple->import_from('config.ini', \%Config);
my $cfg = new Config::Simple('./config/config.ini');
my $Config = $cfg->vars();

#Globals used often throughout script
my $CSS = $Config->{'CSS.min_name'};
my $JS = $Config->{'JS.min_name'};
my $BUILD = $Config->{'GLOBAL.build_folder_name'};


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
		deploy();
	
	} else {exit}
}


#Reset permissions so Perl can execute on certain files (just in case)
sub reset_permissions {
	proclaim("RESET PERMISSIONS");
	system("chmod -R $Config->{'GLOBAL.perms'} ./");
}

#Clear out our old build folder
sub clear_old_build {
	proclaim("CLEAR OUT BUILD FOLDER");
	system("rm -R ./$BUILD/* || mkdir $BUILD");
}

#Move all the PHP files over to the build
#Replace all links (href) from .php to .html to adapt to new raw HTML state
sub transfer_php {
	
	my @php_files = split(/\s/,`find . -name '*.php' -depth 1`);
	my $full_URL;
	my $no_extension_URL;
	
	foreach(@php_files){

		$full_URL = substr($_, 2);
		$no_extension_URL = substr($_, 2, -4);
		print "Downloading $full_URL \n";
		
		system("wget $Config->{'GLOBAL.web_address'}$full_URL -O./build/$no_extension_URL.html.tmp");
		`sed -e 's/.php/.html/g' -e '/<link/d' -e '/defer/d' -e 's#<!--GLOBAL JS FILE GOES HERE (PRODUCTION)-->#<script defer src="js/$JS"></script>#g' -e 's#<!--GLOBAL CSS FILE GOES HERE (PRODUCTION)-->#<link href="css/$CSS" rel="stylesheet">#g' ./build/$no_extension_URL.html.tmp > ./build/$no_extension_URL.html`;
 		system("mv $BUILD/$no_extension_URL.html $BUILD/$no_extension_URL.html.tmp");
		system("tidy -config ./config/HTML_TIDY $BUILD/$no_extension_URL.html.tmp > $BUILD/$no_extension_URL.html");
		system("rm ./$BUILD/$no_extension_URL.html.tmp");
	}
}


sub transfer_css {
	
	proclaim("BEGIN CSS MINIFICATION");
	
	system("mkdir ./$BUILD/css");
	
	my @css_beginners = split(/\s/, $Config->{"CSS.order"});
	
	foreach(@css_beginners) {
		system("cat ./css/$_.css >> ./$BUILD/css/$CSS.tmp");
		system("mv ./css/$_.css ./css/$_.bak");
	}

	system("mv ./css/plugins/colorbox.css ./css/plugins/colorbox.bak");
	
	my @css_files = split(/\s/, `find ./css -name "*.css"`);
	
	foreach(@css_files) {
		system("cat $_ >> ./$BUILD/css/$CSS.tmp");
	}
	
	foreach(@css_beginners) {
			system("mv ./css/$_.bak ./css/$_.css");
	}

	system("csstidy ./$BUILD/css/$CSS.tmp --preserve_css=true --remove_bslash=false ./$BUILD/css/$CSS");

	system("mv ./css/plugins/colorbox.bak ./css/plugins/colorbox.css");
	system("cat ./css/plugins/colorbox.css >> ./$BUILD/css/$CSS");
	system("rm ./$BUILD/css/*.css.tmp");
	
	proclaim("END CSS MINIFICATION");
}

sub transfer_js {
	
	proclaim("BEGIN JS MINIFICATION");

	system("mkdir ./$BUILD/js");
	
	my @js_files = split(/\s/, `find ./js -name "*.js" -depth 1`);
	
	foreach(@js_files) {
		print "merging $_ \n";
		system("cat $_ >> ./$BUILD/$JS.tmp");
	}
	
	system("java -jar ./config/yui/build/yui.jar --type js --line-break 100 ./$BUILD/$JS.tmp > ./$BUILD/js/$JS");
	system("rm ./$BUILD/*.js.tmp");
	system("cp -R ./js/plugins ./$BUILD/js/plugins");
	
	proclaim("END JS MINIFICATION");
	
}

sub move_assets {
	
	proclaim("MOVE OTHER ASSETS");
	
	my @assets = split(/\s/, $Config->{"GLOBAL.assets"});
	
	foreach(@assets) {
		system("cp -R ./$_ ./$BUILD");
	}
	
	system("sed 's/.php/.html/g' ./$BUILD/overlays/product.html > ./$BUILD/overlays/product.html.tmp");
	system("mv ./$BUILD/overlays/product.html.tmp ./$BUILD/overlays/product.html");
	
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

sub ziptest {
	
	proclaim("ZIP TEST");
	system("rm $Config->{'ZIP.name'}.zip");
	system("zip -r $Config->{'ZIP.name'}.zip ./");
	
}



sub proclaim{
	print "==========================$_[0]=============================\n";
}