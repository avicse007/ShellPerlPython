date11=$(date +"%F"  --date="2 days ago")
mkdir $date11.WebLogs
mv i*.txt $date11.WebLogs
tar zcvf $date11.WebLogs.tar.gz $date11.WebLogs

#Username for dumping the search result readlog
