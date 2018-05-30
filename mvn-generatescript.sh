#!/bin/bash

#upload denendency file to nexus, artifact path is get from local .m2/repository
jarfiles="./release.out"
uploadscript="./mvn-uploadtonexus.sh"

username="admin"
password="admin123"
releaseurl="http://10.10.10.199:8081/nexus/content/repositories/releases/"

find ./mvn-repository -name '*.*' -type f | cut -c 18-  > $jarfiles

echo "" > $uploadscript
while read jarpath; do
   echo "upload $jarpath to $releaseurl"
   echo "curl -v -u $username:$password --upload-file ./mvn-repository/$jarpath $releaseurl$jarpath" >> $uploadscript

done <$jarfiles

rm $jarfiles
