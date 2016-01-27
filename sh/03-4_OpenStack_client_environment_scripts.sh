#!/bin/sh

export LANG=en_US.utf8

if [[ -z $1 ]]; then
    echo "** Usage: $0 <Controller IP>"
    exit 1
fi

controller=$1

# Get the Password from OPENSTACK_PASSWD.ini
PW_FILE=OPENSTACK_PASSWD.ini
function get_passwd () { grep ^$1 ${PW_FILE} | awk -F= '{print $2}' | sed 's/ //g'; }

# To Fix the password , Edit these paramters manually.
ADMIN_PASS=`get_passwd ADMIN_PASS`
DEMO_PASS=`get_passwd DEMO_PASS`

echo
echo "Creating openrc-admin."
echo

cat << EOF > ~/openrc-admin
export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default
export OS_PROJECT_NAME=admin
export OS_TENANT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=${ADMIN_PASS}
export OS_AUTH_URL=http://${controller}:35357/v3
export PS1='[\u@\h \W(admin)]\$ '
EOF

echo
echo "** ~/openrc-admin"
cat ~/openrc-admin
echo

echo
echo "Creating openrc-demo."
echo

cat << EOF > ~/openrc-demo
export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default
export OS_PROJECT_NAME=demo
export OS_TENANT_NAME=demo
export OS_USERNAME=demo
export OS_PASSWORD=${DEMO_PASS}
export OS_AUTH_URL=http://${controller}:5000/v3
export PS1='[\u@\h \W(demo)]\$ '
EOF

echo
echo "** ~/openrc-demo"
cat ~/openrc-demo
echo


echo
echo "Done."
