#!/bin/bash

#upload denendency file to nexus, artifact path is get from local .m2/repository
jarfiles="./release.out"
uploadscript="./mvn-uploadtonexus.sh"

username="admin"
password="admin123"
releaseurl="http://10.10.10.199:8081/nexus/content/repositories/releases/"

find ./mvn-dependency -name '*.*' -type f | cut -c 18-  > $jarfiles

echo "" > $uploadscript
while read jarpath; do
  
   artifactpath=`find ~/.m2/repository -name $jarpath | awk '{split($0,a,".m2/repository/"); print a[2]}'`
   echo "upload $artifactpath to $releaseurl"
   echo "curl -v -u $username:$password --upload-file ./mvn-dependency/$jarpath $releaseurl$artifactpath" >> $uploadscript

done <$jarfiles

rm $jarfiles
