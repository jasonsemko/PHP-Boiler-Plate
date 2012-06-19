#!/usr/bin/perl -w

use strict;
use warnings;
use Switch;
use Date::Parse;

#Variables
my $choice;

my $full_stack = 0;											#full stack? This will combine and minify js/css
my $global_assets = 'img overlays';							#folders to copy over to build
                                                      
my $global_permissions = "755";								#standard permissions 							(755)
my $global_build_folder = "build";                          #name of the build folder 						(build)
my $global_web_address = "http://sigmachina.local/";        #the web address root 							(http://somesite.local/)

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
	
	if($global_web_address eq "http://somesite.local") {
		print "Error: You need to specify your host, please setup your variables in ./config/deploy.pl\n$global_web_address\n";
		exit
	}

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
	}
}


sub transfer_css {
	
	proclaim("BEGIN CSS MINIFICATION");
	
	#Make the css directory
	system("mkdir ./$global_build_folder/css");
	system("cp -R ./css ./$global_build_folder");

	#test out csstidy
	system("csstidy > /dev/null 2>&1");
	
	#Yes we have csstidy, use it
	if($? == 0) {
		my @css_files = split(/\s/, `find ./$global_build_folder/css -name "*.css"`);
		foreach(@css_files) {
			system("csstidy $_ --preserve_css=true --remove_bslash=false $_");
		}
	}
	
	proclaim("END CSS MINIFICATION");
}

sub transfer_js {
	
	proclaim("BEGIN JS MINIFICATION");

	system("mkdir ./$global_build_folder/js");
	system("cp -R ./js ./$global_build_folder");
	
	my @js_files = split(/\s/, `find ./$global_build_folder/js -name "*.js"`);
	foreach(@js_files) {
		system("java -jar ./config/yui/build/yui.jar --type js --line-break 100 $_ > $_.tmp");	
		system("mv $_.tmp $_");
	}	
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
	my $timer = time();
	$timer = localtime($timer);
	$timer =~ s/ /_/g;

	proclaim("ZIP IT UP");
	system("rm ./*.zip > /dev/null 2>&1");
	
	if($zip_append_timestamp) {
		system("zip -r $zip_name$timer ./$global_build_folder");
	} else {
		system("zip -r $zip_name ./$global_build_folder");
	}
}

sub deploy {	
	system("rsync -rv --progress -e 'ssh -p $server_port' ./$global_build_folder $server_user\@$server_server:$server_dest");
}

sub proclaim{
	print "==========================$_[0]=============================\n";
}