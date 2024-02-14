#!/bin/bash

cp -r geoserver-geonode-ext geoserver/src/web/app/target/
pushd geoserver/src/web/app/target/

# Output folder with artifacts
mkdir artifacts

mv geoserver.war geoserver_vanilla.war
# Copy geoserver_vanilla.wat artifact
cp geoserver_vanilla.war artifacts/

# Inflate data folder in geonode.war
mkdir _tmp
pushd _tmp
unzip ../geoserver_vanilla.war
cp -r ../geoserver-geonode-ext/data ./
zip -r ../artifacts/geoserver.war ./
popd

# Create zip artifact for data
pushd geoserver-geonode-ext
zip -r ../artifacts/geonode-geoserver-ext-web-app-data.zip data/
popd

# Cleaning up
rm -Rf _tmp/