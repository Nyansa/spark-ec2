service_name="voyance-sparkec2"
nyansa_dir=/opt/voyance
package_dir=${nyansa_dir}/${service_name}

cd ${package_dir}
echo "Removing contents of \"${package_dir}\" directory"
sudo rm -rf *