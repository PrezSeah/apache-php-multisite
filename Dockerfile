FROM ubuntu:latest
MAINTAINER Santiago Pérez <rivenvirus@gmail.com>

ADD policy-rc.d /usr/sbin/policy-rc.d

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN apt-get update && apt-get install -y --force-yes  apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-memcache php5-memcached php5-gd php5-mysql
    
# Configure apache
RUN a2enmod rewrite
ENV APACHE_DIR /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_SITES_ENABLED /etc/apache2/sites-enabled/

VOLUME ${APACHE_DIR}
VOLUME ${APACHE_LOG_DIR}
VOLUME ${APACHE_SITES_ENABLED}

RUN chown -R www-data:www-data ${APACHE_DIR}

RUN apt-get clean;\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]