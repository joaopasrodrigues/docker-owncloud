#!/bin/bash
set -e

echo "Downloading OwnCloud ${OWNCLOUD_VERSION}..."
mkdir -p ${OWNCLOUD_INSTALL_DIR}
wget -nv "https://download.owncloud.org/community/owncloud-${OWNCLOUD_VERSION}.tar.bz2" -O - | tar -jxf - --strip=1 -C ${OWNCLOUD_INSTALL_DIR}

cat > ${OWNCLOUD_INSTALL_DIR}/.user.ini <<EOF
default_charset='UTF-8'
output_buffering=off
upload_max_filesize=2048M
post_max_size=2048G
EOF

echo "Setting strong directory permissions..."
find ${OWNCLOUD_INSTALL_DIR}/ -type f -print0 | xargs -0 chmod 0640
find ${OWNCLOUD_INSTALL_DIR}/ -type d -print0 | xargs -0 chmod 0750

chown -R root:${OWNCLOUD_USER} ${OWNCLOUD_INSTALL_DIR}/
chown -R ${OWNCLOUD_USER}:${OWNCLOUD_USER} ${OWNCLOUD_INSTALL_DIR}/apps/
chown -R ${OWNCLOUD_USER}:${OWNCLOUD_USER} ${OWNCLOUD_INSTALL_DIR}/config/
chown -R ${OWNCLOUD_USER}:${OWNCLOUD_USER} ${OWNCLOUD_INSTALL_DIR}/themes/
chown root:${OWNCLOUD_USER} ${OWNCLOUD_INSTALL_DIR}/.htaccess
chmod 0644 ${OWNCLOUD_INSTALL_DIR}/.htaccess