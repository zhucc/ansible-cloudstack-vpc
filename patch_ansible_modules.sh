#!/bin/bash -

patch_dir="patches"

echo "Gathering list of patches to apply"
file_list=`ls ${patch_dir}`

echo "Update mlocate db"
updatedb

for file in ${file_list};
do
	echo "Find dir for module ${file}..."
	file_location=`locate ${file} | grep dist-pac | head -1`
	dir=`dirname ${file_location}`

	echo "Remove old module ${file}* files"
	rm -rf ${dir}/${file}*

	echo "Copy patched ${file} version..."
	cp ${patch_dir}/${file} ${dir}
done

