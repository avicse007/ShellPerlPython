#!/bin/sh
Port=(7001 7003 6001 5001 9060 10446 10456 10410 10420 10220 10230 10640 9050)
Tomcat_Name=(web-tomcat web2-tomcat web4-tomcat web3-tomcat  review-web-tomcat  review-matrix-tomcat  review-matrix-seo-tomcat  recommendation-web-tomcat  recommendation-admin-web-tomcat  snapdeal-promo-tomcat  snapdeal-cart-tomcat  sitemap-tomcat matrix-tomcat)
# get length of an array
arraylength=${#Tomcat_Name[@]}
for (( i=0; i<${arraylength}; i++ )); do
	echo "###################################################################"
	echo Builds on tomcat ":" ${Tomcat_Name[$i]} with Port ":" ${Port[$i]} 
	echo 
	tail -f --q /usr/local/${Tomcat_Name[$i]}/webapps/ROOT/META-INF/MANIFEST.MF &tailpid=$!
	disown
	sleep 1
	kill -9 $tailpid
	#wait $tailpid 2>/dev/null
done
echo "##################DONE################################"
