#---------------------------------------------Providing Options to User for applying different groupBys----------------------------------
$userWantOneMore=1;
while($userWantOneMore>0)
{
print "Please select the option from the below choices \n";
print "1. groupBy time\n2. groupBy API name\n3. groupBy ELB\n4.groupBy ERROR tag\n";	
$groupByChoice=<STDIN>;
chomp($groupByChoice);
#Do something 
if($groupByChoice==1){
 groupbyTime();
 }
 elsif($groupByChoice==2){
   groupbyAPIname();
  }
  elsif($groupByChoice==3){
   groupbyELBname();  
   }
   elsif($groupByChoice==4){
      groupbyError();
    }
    else{
     print "Please select correct option out of 1,2,3 nad 4"
     }
#Then ask again
print "Do you want to apply group by on the file Yes:y  or NO: n\n";
$userChoice=<STDIN>;
chomp($userChoice);
$userWantOneMore=0;
if($userChoice eq "Y"||$userChoice eq "y"){
	$userWantOneMore=1;
}
else{
	$userWantOneMore=-10;
	}
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 #---------------------------------Methods that we will be using to implement groupby------------------------------------------------------
 #Methods for groupby time in art serverlog
  sub groupbyTime{
  print "Please enter the start time in 24 hrs format eg for 2PM type 14\n ";
  $startTime=<STDIN>;
  print "Please enter the end time in 24 hrs format eg for 3PM type 15\n ";
  $endTime=<STDIN>;
  chomp($startTime);
  chomp($endTime);
  $regexp="(^$startTime:|^$endTime:)";
  chomp($regexp);
  print "Your regular expression is $regexp\n ";
  #Main File from which we will read tha data
  $file='art_server.log';
  #This file will act as temp file if not temp file was created
  $tempfile='temp1.txt';
  #This is the is our first temp file 
  $tempFile1='temp1.txt';
  #This is the is our second temp file 
  $tempFile2='temp2.txt';
  #if tempfile1 exists that means use are using second groupby so source file will be the tempfile1
  if(-e $tempFile1){
    $file=$tempFile1;
    #Set temporary file to be created as second temp file
    $tempfile=$tempFile2;
   }
   #Else if tempfile2 exists that means use are using second+1 groupby so source file will be the tempfile2
   elsif(-e $tempFile2){
    $file=$tempFile2;
    #As secondtemp file already exists Set temporary file to be created as first temp file
    $tempfile=$tempFile1;
    }
    else{
     
     }
     
     print "our source file is : $file \n";
     print "Our Destination file is :  $tempfile";
  #open the file to write
  open(my $fh, '>', $tempfile) || die "Could not open file $tempfile";
  open(INFO, $file) || die("Could not open  file. $file");
  foreach $line (<INFO>){
    chomp($line);
    if($line =~m/$regexp/g){
        print "$line\n";
        #write to input file
        print $fh "$line\n";
        }
  }
  close(INFO) || die "Couldn't close file properly";
  #close the output file
  close $fh || die "Couldn't close file properly";
  print "Done \n";
  print "Your are getting logs from  $startTime to $endTime\n";
  #Now check which temp file you have to delete based on from which source file do you read.
  if($file eq "temp1.txt"){
   print "Deleting this file : $file\n";
   unlink $file;
   }
   if($file eq "temp2.txt"){
    print "Deleting this file : $file\n";
    unlink $file;
    }
  
  
 }
 #-------------------------------------------------------------------------------------------- 
 #Method for groupby API name in the art serverlogs
 sub groupbyAPIname{
  print "Please enter the apiname that you wish to parse\n ";
  $apiName=<STDIN>;
  chomp($apiName);
  $regexp="$apiName";
  chomp($regexp);
  print "Your regular expression is $regexp\n ";
  #Main File from which we will read tha data
  $file='art_server.log';
  #This file will act as temp file if not temp file was created
  $tempfile='temp1.txt';
  #This is the is our first temp file 
  $tempFile1='temp1.txt';
  #This is the is our second temp file 
  $tempFile2='temp2.txt';
  #if tempfile1 exists that means use are using second groupby so source file will be the tempfile1
  if(-e $tempFile1){
    $file=$tempFile1;
    #Set temporary file to be created as second temp file
    $tempfile=$tempFile2;
   }
   #Else if tempfile2 exists that means use are using second+1 groupby so source file will be the tempfile2
   elsif(-e $tempFile2){
    $file=$tempFile2;
    #As secondtemp file already exists Set temporary file to be created as first temp file
    $tempfile=$tempFile1;
    }
  #open the file to write
  open(my $fh, '>', $tempfile) or die "Could not open file '$tempfile' $!";
  open(INFO, $file) or die("Could not open  file.");
  foreach $line (<INFO>){
    chomp($line);
    if($line =~m/$regexp/g){
        print "$line\n";
         #write to input file
        print $fh "$line\n";
        }
  }
  close(INFO) || die "Couldn't close file properly";
  print "Done \n";
  print "Your are getting logs for $apiName \n";
  #close the output file
  close $fh || die "Couldn't close file properly";
  #Now check which temp file you have to delete based on from which source file do you read.
  if($file eq "temp1.txt"){
   unlink $file;
   }
   if($file eq "temp2.txt"){
    unlink $file;
    }
 }
#-------------------------------------------------------------------------------------------- 
 #Method for groupby ElB name in the art serverlogs
 sub groupbyELBname{
  print "Please enter the ELB name that you wish to parse\n eg internal-catalog-lb-2016199727.ap-southeast-1.elb.amazonaws.com \n ";
  $elbName=<STDIN>;
  chomp($elbName);
  $regexp="$elbName";
  chomp($regexp);
  print "Your regular expression is $regexp\n ";
  #Main File from which we will read tha data
  $file='art_server.log';
  #This file will act as temp file if not temp file was created
  $tempfile='temp1.txt';
  #This is the is our first temp file 
  $tempFile1='temp1.txt';
  #This is the is our second temp file 
  $tempFile2='temp2.txt';
  #if tempfile1 exists that means use are using second groupby so source file will be the tempfile1
  if(-e $tempFile1){
    $file=$tempFile1;
    #Set temporary file to be created as second temp file
    $tempfile=$tempFile2;
   }
   #Else if tempfile2 exists that means use are using second+1 groupby so source file will be the tempfile2
   elsif(-e $tempFile2){
    $file=$tempFile2;
    #As secondtemp file already exists Set temporary file to be created as first temp file
    $tempfile=$tempFile1;
    }
  #open the file to write
  open(my $fh, '>', $tempfile) or die "Could not open file '$tempfile' $!";
  open(INFO, $file) or die("Could not open  file.");
  foreach $line (<INFO>){
    chomp($line);
    if($line =~m/$regexp/g){
        print "$line\n";
         #write to input file
        print $fh "$line\n";
        }
  }
  close(INFO) || die "Couldn't close file properly";
  print "Done \n";
  print "Your are getting logs for $elbName \n";
  #Now check which temp file you have to delete based on from which source file do you read.
  if($file eq "temp1.txt"){
   unlink $file;
   }
   if($file eq "temp2.txt"){
    unlink $file;
    }
 }
 #--------------------------------------------------------------------------------------------
 #Method for groupby ERROR tag in the art serverlogs
 sub groupbyError{
  $regexp="ERROR";
  chomp($regexp);
  print "Your regular expression is $regexp\n ";
  #Main File from which we will read tha data
  $file='art_server.log';
  #This file will act as temp file if not temp file was created
  $tempfile='temp1.txt';
  #This is the is our first temp file 
  $tempFile1='temp1.txt';
  #This is the is our second temp file 
  $tempFile2='temp2.txt';
  #if tempfile1 exists that means use are using second groupby so source file will be the tempfile1
  if(-e $tempFile1){
    $file=$tempFile1;
    #Set temporary file to be created as second temp file
    $tempfile=$tempFile2;
   }
   #Else if tempfile2 exists that means use are using second+1 groupby so source file will be the tempfile2
   elsif(-e $tempFile2){
    $file=$tempFile2;
    #As secondtemp file already exists Set temporary file to be created as first temp file
    $tempfile=$tempFile1;
    }
  #open the file to write
  open(my $fh, '>', $tempfile) or die "Could not open file '$tempfile' $!";
  open(INFO, $file) or die("Could not open  file.");
  foreach $line (<INFO>){
    chomp($line);
    if($line =~m/$regexp/g){
        print "$line\n";
          #write to input file
        print $fh "$line\n";
        }
  }
  close(INFO) || die "Couldn't close file properly";
  print "Done \n";
  print "Your are getting logs for ERROR tag \n";
  #Now check which temp file you have to delete based on from which source file do you read.
  if($file eq "temp1.txt"){
   unlink $file;
   }
   if($file eq "temp1.txt"){
    unlink $file;
    }
 }
 #--------------------------------------------------------------------------------------------
 
 
 