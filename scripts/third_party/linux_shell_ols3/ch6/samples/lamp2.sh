#! /bin/bash

# �]�w�����s���� MySQL �w�˸��|
ApacheVersion="httpd-2.2.11"
PHPVersion="php-5.3.0"
MYSQLHOME="/usr/local/mysql"

# ����
tar xvzf $ApacheVersion.tar.gz &&
tar xvzf $PHPVersion.tar.gz &&

# �]�w Apache
echo "Configure apache ...." &&
cd $ApacheVersion &&
./configure --prefix=/usr/local/apache2 --enable-so &&
make &&
make install &&

# �]�w/�sĶ/�w�� PHP
cd ../$PHPVersion &&
./configure \
           --with-apxs2=/usr/local/apache2/bin/apxs \
           --with-mysql=$MYSQLHOME &&
make &&
make install &&

# ���� php.ini �� /usr/local/lib
cp -f php.ini-production /usr/local/lib/php.ini &&

echo
echo 'Done!'
echo
