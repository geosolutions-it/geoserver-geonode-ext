#!/bin/bash

REGION="eu-south-1"
BUCKET="artifacts.geonode.org"
PATH="geoserver/$GEOSERVER_VERSION"
GIT_BRANCH=$GEOSERVER_VERSION
PROFILE="jenkins"

# Download DATA DIR and custom Libs

pushd src/web/app/target/
/usr/bin/wget https://github.com/GeoNode/geoserver-geonode-ext/archive/refs/heads/$GIT_BRANCH.zip -O geoserver-geonode-ext-$GIT_BRANCH.zip
/usr/bin/unzip geoserver-geonode-ext-$GIT_BRANCH.zip

# Prepare the geoserver.war and geoserver_vanilla.war packages
/bin/mv geoserver.war geoserver_vanilla.war
/bin/mkdir _tmp
pushd _tmp
/usr/bin/unzip ../geoserver_vanilla.war

# Replace Libs-* Plugins-* JARs
## getting rid of clashing/outdated dependencies
#/bin/rm -Rf WEB-INF/lib/print-lib-*
#/bin/rm -Rf WEB-INF/lib/asm-3.1.jar
## copying the new ones
#/bin/cp ../geoserver-geonode-ext-$GIT_BRANCH/libs/*.jar WEB-INF/lib/
#/bin/cp ../geoserver-geonode-ext-$GIT_BRANCH/plugins/*.jar WEB-INF/lib/
#/bin/rm -Rf ../geoserver_vanilla.war
#/usr/bin/zip -r ../geoserver_vanilla.war ./

# Replace GEOSERVER_DATA_DIR
/bin/rm -Rf data/
/bin/cp -r ../geoserver-geonode-ext-$GIT_BRANCH/data ./
/usr/bin/zip -r ../geoserver.war ./
popd

# Prepare the geonode-geoserver-ext-web-app-$GEOSERVER_VERSION-data.zip artifact containing the GEOSERVER_DATA_DIR
pushd geoserver-geonode-ext-$GIT_BRANCH/
/usr/bin/zip -r ../geonode-geoserver-ext-web-app-data.zip data/
popd

# Cleaning up
/bin/rm -Rf _tmp/
/bin/rm -Rf geoserver-geonode-ext-$GIT_BRANCH.zip
popd

echo "AWS client id: $AWS_ACCESS_KEY_ID"
echo "AWS client secret: $AWS_SECRET_ACCESS_KEY"