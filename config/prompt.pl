#!/usr/bin/perl

use strict;
use warnings;

print "***********Welcome! What would you like to do today?***********\n\n";
print "***********Deploy to (D)ev***********\n";
print "***********Deploy to (S)taging***********\n";
print "***********(Z)ip up Files***********\n";

my $command = <>;
chomp($command);

if($command eq "D" || $command eq "d") {
	system("make deploy-dev");
}
if($command eq "S" || $command eq "s") {
	system("make deploy-staging");
}
if($command eq "Z" || $command eq "z") {
	system("make zip");
}
