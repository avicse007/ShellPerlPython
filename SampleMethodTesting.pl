do
{
print "Please select the option from the below choices \n";
print "1. groupBy time\n2. groupBy API name\n3. groupBy ELB\n4.groupBy ERROR tag\n";	
$groupByChoice=<STDIN>;
chomp($groupByChoice);
#Do something 
$filename="Sample.txt";
if(-e $filename){
 print "File exists at the given location with filename: $filename \n Deleting it";
 unlink $filename;
 name $old_name, $new_name;	
}
 

print "Do you want to apply group by on the file Yes:y  or NO: n\n";
$userChoice=<STDIN>;
chomp($userChoice);
$userWantOneMore=0;
if($userChoice=="Y"||$userChoice=="y"){
}
else{
	$userWantOneMore=0;



 # $filename="Sample.txt";
 # print $fh "My first report generated by perl\n";
 # close $fh;
 # print "done\n";
 # if($filename=="Sample.txt"){
# print "File exists at the given location with filename: $filename \n";	
# else {
# print "File does not exists at the given location with given filename : $filename\n";	
	