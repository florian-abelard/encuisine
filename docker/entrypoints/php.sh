#!/bin/sh

composer install --no-progress --prefer-dist --optimize-autoloader

chown -R `stat -c "%u:%g" composer.json` ./var/
chown -R `stat -c "%u:%g" composer.json` ./vendor/

./bin/console doctrine:database:drop --if-exists --force
./bin/console doctrine:database:create
./bin/console doctrine:schema:update --force --no-interaction --complete

php-fpm
