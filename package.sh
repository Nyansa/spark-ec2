#!/bin/bash -e

source common.sh

echo "Initialize project"
gradle clean

echo "Creating tar files"
tar -cvf ec2.tar .

echo "Updating version in build.gradle"
version=`git describe`
sed -i -e "s/VERSION_STRING/${version}/g" build.gradle

echo "Generating debian"
gradle build buildDeb

echo "Reverting version string in build.gradle"
sed -i -e "s/${version}/VERSION_STRING/g" build.gradle
sudo rm -rf build.gradle-e ec2.tar

deb_file=`ls build/distributions/ | grep deb`
repository_key=$(get_repository_key)
echo "Publishing \"${deb_file}\" file to \"${repository_key}\" repository"
curl -u admin:${ARTIFACTORY_ADMIN_PASSWORD} -f -X PUT "https://voyance.jfrog.io/voyance/${repository_key}/pool/${deb_file};deb.distribution=voyance;deb.component=private;deb.architecture=amd64" -T build/distributions/${deb_file} > /dev/null