#!/bin/bash

# define key information
src=db
dbname=quotes_development
dbname_test=quotes_test
dbuser=quotes
dbpassword="qualcosa di complicato"

# no customization needed beyond this line

set -e

if [ ! -d "$src" ]; then
  echo "Run this script from the main directory of the project"
  exit 1
fi
read -s -p "mysql root password? (type return for no password) " MYSQL_ROOT_PASSWORD

if [ "$MYSQL_ROOT_PASSWORD" != "" ]; then
    MYSQL_ROOT_PASSWORD=-p$MYSQL_ROOT_PASSWORD
fi

mysqladmin -uroot $MYSQL_ROOT_PASSWORD         drop $dbname
mysqladmin -uroot $MYSQL_ROOT_PASSWORD --force drop $dbname_test

echo "create database $dbname      default charset utf8;" | mysql -uroot $MYSQL_ROOT_PASSWORD
echo "create database $dbname_test default charset utf8;" | mysql -uroot $MYSQL_ROOT_PASSWORD

echo "grant all on $dbname.* to '$dbuser'@localhost identified by '$dbpassword';" \
     | mysql -uroot $MYSQL_ROOT_PASSWORD 
echo "grant all on $dbname_test.* to '$dbuser'@localhost identified by '$dbpassword';" \
      | mysql -uroot $MYSQL_ROOT_PASSWORD 


cat $src/???_*.sql | mysql -u$dbuser "-p$dbpassword" $dbname 
cat $src/???_*.sql | mysql -u$dbuser "-p$dbpassword" $dbname_test 

echo "$dbname created"
