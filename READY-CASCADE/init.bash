#!/bin/bash

if [ $# != 1 ] ; then
    echo "Please provide a package name" 1>&2
    exit 1
fi

package_name_upper=`echo $1 | tr "[:lower:]" "[:upper:]"`
package_name_lower=`echo $1 | tr "[:upper:]" "[:lower:]"`

sed -i -e "s/package_name_here/$package_name_lower/g" setup.bash
sed -i -e "s/EXAMPLE/$package_name_upper/g" setup.bash

sed -i -e "s/EXAMPLE/$package_name_upper/g" devel.bash

for file in packages/CASCADE-MAKE-SCRIPTS/*.sh ; do
    [ -f "${file}" ] || continue
    sed -i -e "s/EXAMPLE/$package_name_upper/g" "${file}"
done

rm -- "$0"
