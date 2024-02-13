#!/bin/bash

la geoserver-geonode-ext

cp -r geoserver-geonode-ext src/web/app/target/
pushd geoserver/src/web/app/target/

mkdir artifacts
# Prepare the geoserver.war and geoserver_vanilla.war packages
mv geoserver.war geoserver_vanilla.war
mkdir _tmp

pushd _tmp # src/web/app/target/_tmp
unzip ../geoserver_vanilla.war


cp -r ../geoserver-geonode-ext/data ./
zip -r ../artfacts/geoserver.war ./
popd

pushd geoserver-geonode-ext

zip -r ../artfacts/geonode-geoserver-ext-web-app-data.zip data/
popd

# Cleaning up
rm -Rf _tmp/

popd