FROM php:5.6-apache
MAINTAINER Najar Ramsada <ramsadanajar@gmail.com>

ENV PHPIPAM_SOURCE https://github.com/phpipam/phpipam/
ENV PHPIPAM_VERSION 1.3.2
ENV PHPMAILER_SOURCE https://github.com/PHPMailer/PHPMailer/
ENV PHPMAILER_VERSION 5.2.21
ENV PHPSAML_SOURCE https://github.com/onelogin/php-saml/
ENV PHPSAML_VERSION 2.10.6
ENV WEB_REPO /var/www/html

# Install required deb packages and copy phpipam scan agent from github
RUN sed -i /etc/apt/sources.list -e 's/$/ non-free'/ && \
    apt-get update && apt-get -y upgrade && \
    apt-get -y install cron && apt-get -y install vim && apt-get -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev git &&\
    rm /etc/apt/preferences.d/no-debian-php && \
    apt-get install -y libcurl4-gnutls-dev libgmp-dev libmcrypt-dev libfreetype6-dev libjpeg-dev libpng-dev libldap2-dev libsnmp-dev snmp-mibs-downloader iputils-ping && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
	mkdir -p /ipamscan && \
	git clone https://github.com/phpipam/phpipam-agent.git /ipamscan

# Copy the php.ini, config.php, crontab file required for phpIPAM scan agent to work
COPY php.ini /usr/local/etc/php/
COPY config.php /ipamscan/
COPY ipamscancron /etc/cron.d/ipamscancron
RUN chmod 0644 /etc/cron.d/ipamscancron && \
	service cron start


# Install required packages and files required for snmp
RUN mkdir -p /var/lib/mibs/ietf && \
    curl -s ftp://ftp.cisco.com/pub/mibs/v2/CISCO-SMI.my -o /var/lib/mibs/ietf/CISCO-SMI.txt && \
    curl -s ftp://ftp.cisco.com/pub/mibs/v2/CISCO-TC.my -o /var/lib/mibs/ietf/CISCO-TC.txt && \
    curl -s ftp://ftp.cisco.com/pub/mibs/v2/CISCO-VTP-MIB.my -o /var/lib/mibs/ietf/CISCO-VTP-MIB.txt && \
    curl -s ftp://ftp.cisco.com/pub/mibs/v2/MPLS-VPN-MIB.my -o /var/lib/mibs/ietf/MPLS-VPN-MIB.txt

# Configure apache and required PHP modules
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
    docker-php-ext-install mysqli && \
    docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include && \
    docker-php-ext-install gd && \
    docker-php-ext-install curl && \
    docker-php-ext-install json && \
    docker-php-ext-install snmp && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install gettext && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu && \
    docker-php-ext-install gmp && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install pcntl && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    docker-php-ext-install ldap && \
    echo ". /etc/environment" >> /etc/apache2/envvars && \
    a2enmod rewrite