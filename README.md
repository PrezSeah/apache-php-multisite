# APACHE & PHP MultiSite - VirtualHosts

This is a setup to run apache & php with the ability to configure virtual hosts easily in a docker orquestation, includes a docker-compose.yml example.

**PHP Libs**

* php5-mcrypt
* php5-curl
* php5-memcache
* php5-memcached
* php5-gd
* php5-mysql


### Install docker, compose, and machine

```
brew update
brew install docker docker-compose docker-machine
```


### InstallVirtualbox
[Download Virtualbox](https://www.virtualbox.org/wiki/Downloads)



### Setup docker environment

```
docker-machine create -d virtualbox dev
docker-machine start dev
$(docker-machine env dev)
```


## Run a container

```
docker run -i -t --rm -p 80:80 -v /sites-enabled-folder:/etc/apache2/sites-enabled/ -v /www-folder:/var/www/ rivenvirus/apache-php-multisite
```


### Configuration on Docker Compose

```
apache:
  image: rivenvirus/apache-php-multisite
  links:
    - mysql
    - memcached
  ports:
    - "80:80"
  volumes:
    - ./sites-enabled:/etc/apache2/sites-enabled
    - ./www:/var/www
mysql:
  image: mysql
  ports:
    - "3306:3306"
  environment:
    MYSQL_ROOT_PASSWORD: 123
    MYSQL_USER: root
    MYSQL_PASSWORD: 123
memcached:
  image: memcached
  ports:
    - "11211:11211"
```


### Build & Run!

```
docker-compose build
docker-compose up -d
```


### Stop

```
docker-compose kill
```


### Example & Source Code
[https://github.com/rivenvirus/apache-php-multisite](https://github.com/rivenvirus/apache-php-multisite)