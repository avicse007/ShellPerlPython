#!/bin/sh

#making file 
date11=$(date +"%F"  --date="2 days ago")
f=server.log
filename="$f.$date11"
filename2="$filename.bz2"
echo $filename
avatars=(i-1b8e35bf i-1f94d7bb i-53d8bedd i-22088d86 i-dab86917 i-f0fe9b7e i-46d5a9e2 i-45d5a9e1 i-1d4a96d2 i-1e4a96d1 i-296a17e4 i-2c6d96e0)
#avatars=(i-22088d86 i-dab86917 i-f0fe9b7e i-46d5a9e2 i-45d5a9e1 i-1d4a96d2 i-1e4a96d1 i-296a17e4 i-2c6d96e0)
#avatars=(i-45d5a9e1 i-1d4a96d2 i-1e4a96d1 i-296a17e4 i-2c6d96e0)
serverPathPrefix=s3://sd-logarchive/avatar-
serverPathPostfix=.snapdeal.com/
#make it dynamic
arraylength=${#avatars[@]}
for (( i=0; i<${arraylength}; i++ )); do
	serverfullpath="$serverPathPrefix${avatars[$i]}$serverPathPostfix$filename2"
	#make it dynamic
	finaloutput="${avatars[$i]}OutputResponse.txt"
	echo $serverfullpath
	aws s3 cp $serverfullpath .
	bzip2 -dk  $filename2
	echo "Executing the script"
	a=`wc -l < $filename`
	echo "value of a "
	echo $a
	start=1
	lines=350000 
	while [ $a -gt 0 ]
	do
			#reading top 1000 files from server to output.txt and then deleting them from server file
			echo "The value of a is "
			echo $a
			echo "Reading file for 350000 lines" 
			awk "FNR>=$start && FNR<=$lines"  $filename > output.txt
			#head -`expr $lines` server.log.2016-01-25 > output.txt 
			echo "Done Reading"
			#performing regular expression on the output.txt and storing result in finalOutPut.txt
			#it should append value in finalOutput.txt
			# cat output.txt | grep "getSearchResults \: keyword\: \[.*\]\,requestId\: \[.*\]"|awk '{print $7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22}' >>finalOutPut.txt
			#for the new request 
			 #grep -o -P "^[0-9]+\:[0-9]+\:[0-9]+.*getSearchResults \: keyword\: \[.*\]\,"
			 #Old one
			 #grep -o -P  "getSearchResults \: keyword\: \[.*\]\,requestId\: \[.*\]""
			cat output.txt | grep -o -P "^[0-9]+\:[0-9]+\:[0-9]+.*getSearchResults \: keyword\: \[.*\]\," >> $finaloutput

			#grep 'getSearchResults'  >> finalOutPut.txt
			#a=`wc -l < server.log.2016-01-25`
			a=`expr $a - $lines`
			echo $a
			start=`expr $start + $lines`
			lines=`expr $lines + $lines`
			echo "start"
			echo $start
			echo "diff"
			diff=`expr $lines - $start`
			echo $diff
			echo "Lines"
			echo $lines
	done
	echo "Done executing the script"
	echo $filename
	echo $filename2
	echo "Deleting files"
	rm "$filename"
	rm "$filename2"
	#rm output.txt
done
echo "##############################################################################################################################"
echo "#########################################DONE PARSING ALL THE SERVERS##############################################################"
echo "##############################################################################################################################"
echo "#########################################Zipping THE SERVERS##############################################################"
mkdir $date11.WebLogs
mv i*.txt $date11.WebLogs
tar zcvf $date11.WebLogs.tar.gz $date11.WebLogs
