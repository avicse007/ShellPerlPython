#user/bin/perl
#use strict;
#use warnings;
print "Hello world \n";
#Regular expression to apply for art server for group by time from 10 to 11
#$regExp="^(10:|11:)";
#For api name getMinPOGContentListByIdList
#$regExp="getMinPOGContentListByIdList";
#For ERROR 
#$regExp="ERROR[\W\w\s]*.*";
#Regular expression for elb name 
#print  "Enter the elb name ";
$regExp="internal-catalog-lb-2016199727.ap-southeast-1.elb.amazonaws.com";
#$regExp="internal-IPMS-ELB-2-582574953.ap-southeast-1.elb.amazonaws.com";
#print "Please enter the file name";
# $file='art_server.log';
 print "Your regular expression is : $regExp"; 
$file='art_server.log.filepart';
open(INFO, $file) or die("Could not open  file.");
foreach $line (<INFO>){
chomp($line);
if($line =~m/$regExp/g){
print "$line\n";
}
}
close(INFO) || die "Couldn't close file properly";
print "Done \n"
#$string ="Hello Sir"
#$reg="^Hell";
#if (($string =~/reg/){

#}

#group by timestamp
#group by elb name
#group by api
#group by ERROR
#group by api name with top most response time 
