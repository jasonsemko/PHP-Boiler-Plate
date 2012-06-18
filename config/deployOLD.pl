#!/usr/bin/perl -w

use strict;
use warnings;
use Switch;

#Variables
my $choice;

my $full_stack = 0;											#full stack? This will combine and minify js/css
                                                      
my $global_permissions = "755";								#standard permissions 							(755)
my $global_assets = "img overlays css/plugins";             #any other assets should be added to this chain (img overlays)
my $global_build_folder = "build";                          #name of the build folder 						(build)
my $global_web_address = "http://sigmachina.local/";        #the web address root 							(http://somesite.local/)
my $global_tidy = 0;                                        #1 = true for html tidy 						(0)
                                                            
my $css_min_name = "global.min.css";                        #name for minified/pretty global css file		(global.min.css)
my $css_order = "base global";                              #which files should come first in the css?		(base global)
                                                            
my $js_min_name = "global.min.js";                          #javascript minified/pretty file name			(global.min.js)
                                                            
my $zip_name = "Project";                                   #name of zip file								(Project)
my $zip_append_timestamp = 1;                               #append a time stamp?							(1)
                                                            
my $deploy = 0; 											#Do you deploy? 				            	(0)
my $server_user = "username";                               #Username										(username)
my $server_port = "1124";                                   #Port 											(0) if 0 do not use port
my $server_server = "nyicolo-dev###";                       #Server											(nyicolo-dev###)
my $server_dest = "/path/to/html/files";                    #Folder on server to place files via rsync		(/path/to/html/files)
                                                            
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
	
	# TODO This does not work for some reason.
	#if($global_web_address == "http://somesite.local") {
	#	print "Error: You need to specify your host, please setup your variables in ./config/deploy.pl\n$global_web_address\n";
	#	exit
	#}

	if($choice eq "C" || $choice eq "c") {
	
		reset_permissions();
		clear_old_build();
		transfer_php();
		transfer_css();
		transfer_js();
		move_assets();
		zip();
		#for testing no need to continually deploy to server, this works
		if($deploy) { deploy();}
	
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
	
	# TODO This goes one level deep, this needs to go as deep as possible...or final files are always at top and other pages are raw html
	my @php_files = split(/\s/,`find . -name '*.php' -depth 1`);
	my $full_URL;
	my $no_extension_URL;
	
	foreach(@php_files){
		# TODO In relation to above TODO, potential solution, if($_ =~ $pattern)
		#print("jason" =~ "/(jason | jane)");
		
		$full_URL = substr($_, 2);
		$no_extension_URL = substr($_, 2, -4);
		
		system("wget $global_web_address$full_URL -O./$global_build_folder/$no_extension_URL.html");
		
		#replace all .php links with .html
		`sed -e 's/.php/.html/g' -i "" ./$global_build_folder/$no_extension_URL.html`;
		
		#if we are full stack
			#remove all css and deferred javascript tags (replace with global)
			#`sed -e '/<link/d' -e '/defer/d' -i "" ./$global_build_folder/$no_extension_URL.html`;			
			#Insert global JS in appropriate place
			#`sed -e 's#<!--GLOBAL JS FILE GOES HERE (PRODUCTION)-->#<script defer src="js/$js_min_name"></script>#g' -i "" ./$global_build_folder/$no_extension_URL.html`;		
			#Insert global CSS in apprpriate place
			#`sed -e 's#<!--GLOBAL CSS FILE GOES HERE (PRODUCTION)-->#<link href="css/$css_min_name" rel="stylesheet">#g' -i "" ./$global_build_folder/$no_extension_URL.html`;
		#else just move the js and css over
			
		#Tidy up HTML?
		#if($global_tidy) {
		#	`tidy -m -config ./config/HTML_TIDY $global_build_folder/$no_extension_URL.html`;
		#}
	}
}


sub transfer_css {
	
	proclaim("BEGIN CSS MINIFICATION");
	
	#Make the css directory
	system("mkdir ./$global_build_folder/css");
	system("cp -R ./css ./$global_build_folder");
	#put the starting css files (reset, base) into an array, go through and append to new global css file
	#After that change extension to .bak so in next css sweep they are not re-added to global css file
	#my @css_beginners = split(/\s/, $css_order);
	#foreach(@css_beginners) {
	#	`echo "\n\n/****************$_*****************/\n\n" >> ./$global_build_folder/css/$css_min_name`;
	#	system("cat ./css/$_.css >> ./$global_build_folder/css/$css_min_name");
	#	system("mv ./css/$_.css ./css/$_.bak");
	#}
	#system("mv ./css/plugins/colorbox.css ./css/plugins/colorbox.bak");
	
	#Previous css files are .bak now, left over css files can go in any order, add them to global alphabetically
	my @css_files = split(/\s/, `find ./$global_build_folder/css -name "*.css"`);
	foreach(@css_files) {
		print("$_");
		system("csstidy $_ --preserve_css=true --remove_bslash=false $_");
	}
	#foreach(@css_files) {
	#	`echo "\n\n/****************$_*****************/\n\n" >> ./$global_build_folder/css/$css_min_name`;
	#	system("cat $_ >> ./$global_build_folder/css/$css_min_name");
	#}
	
	#Now that all css has been added to global, return from .bak to .css
	#foreach(@css_beginners) {
	#		system("mv ./css/$_.bak ./css/$_.css");
	#}

	#test out csstidy
	system("csstidy > /dev/null 2>&1");
	
	#Yes we have csstidy, use it
	if($? == 0) {
		#proclaim("CSS TIDY ME UP");
		system("csstidy ./$global_build_folder/css/$css_min_name.tmp --preserve_css=true --remove_bslash=false ./$global_build_folder/css/$css_min_name.tmp");	
	}

	#move colorbox.bak to colorbox.css and append it to global (need to find better way to do this, use folder)
	#system("mv ./css/plugins/colorbox.bak ./css/plugins/colorbox.css");
	#system("cat ./css/plugins/colorbox.css >> ./$global_build_folder/css/$css_min_name");
	
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
	system("rm ./$global_build_folder/js/*.tmp");
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
	
	system("chmod -R 755 ./");
}

sub zip {
	proclaim("ZIP IT UP");
	system("rm $zip_name > /dev/null 2>&1");
	system("zip -r $zip_name ./$global_build_folder");
}

sub deploy {	
	system("rsync -rv --progress -e 'ssh -p $server_port' ./$global_build_folder $server_user\@$server_server:$server_dest");
}

sub proclaim{
	print "==========================$_[0]=============================\n";
}