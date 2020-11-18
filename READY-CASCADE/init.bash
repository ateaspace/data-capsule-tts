#!/bin/bash

read -p "Please enter the name of the package: " package_name
read -p "Please enter a number to specifiy the default number of jobs that make should run in parallel (e.g. make -jN): " parallel_jobs

package_name_upper=`echo $package_name | tr "[:lower:]" "[:upper:]"`
package_name_lower=`echo $package_name | tr "[:upper:]" "[:lower:]"`

sed -i -e "s/package_name_here/$package_name_lower/g" setup.bash
sed -i -e "s/EXAMPLE/$package_name_upper/g" setup.bash

sed -i -e "s/EXAMPLE/$package_name_upper/g" devel.bash

for file in packages/CASCADE-MAKE-SCRIPTS/*.sh ; do
    [ -f "${file}" ] || continue
    sed -i -e "s/EXAMPLE/$package_name_upper/g" "${file}"
done

sed -i -e "s/parallel_jobs_here/$parallel_jobs/g" devel.bash

rm -- "$0"
