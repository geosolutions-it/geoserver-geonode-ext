#!/bin/bash

la geoserver-geonode-ext

cp -r geoserver-geonode-ext src/web/app/target/
pushd geoserver/src/web/app/target/

# Prepare the geoserver.war and geoserver_vanilla.war packages
mv geoserver.war geoserver_vanilla.war
mkdir _tmp

pushd _tmp # src/web/app/target/_tmp
unzip ../geoserver_vanilla.war


cp -r ../geoserver-geonode-ext/data ./
zip -r ../geoserver.war ./
popd

pushd geoserver-geonode-ext

zip -r ../geonode-geoserver-ext-web-app-data.zip data/
popd

# Cleaning up
rm -Rf _tmp/

popd

echo "AWS client id: $AWS_ACCESS_KEY_ID"
echo "AWS client secret: $AWS_SECRET_ACCESS_KEY"