#! /bin/bash

# ����
tar xvzf httpd-2.2.11.tar.gz &&
tar xvzf php-5.3.0.tar.gz &&

# �]�w Apache
echo "Configure apache ...." &&
cd  httpd-2.2.11 &&
./configure --prefix=/usr/local/apache2 --enable-so &&
make &&
make install &&

# �]�w/�sĶ/�w�� PHP
cd ../php-5.3.0 &&
./configure \
           --with-apxs2=/usr/local/apache2/bin/apxs \
           --with-mysql=/usr/local/mysql &&
make &&
make install &&

# ���� php.ini �� /usr/local/lib
cp -f php.ini-production /usr/local/lib/php.ini &&

echo
echo 'Done!'
echo
