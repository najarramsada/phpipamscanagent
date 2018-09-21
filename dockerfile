FROM php:5.6-alpine
MAINTAINER Najar Ramsada (ramsadanajar@gmail.com)

# Install required packages and copy phpipam scan agent from github
RUN apk update && apk upgrade && \
    apk add --no-cache git bash gmp-dev iputils fping && \
	mkdir -p /ipamscan && \
	git clone https://github.com/phpipam/phpipam-agent.git /ipamscan

# Install required PHP extensions 
RUN docker-php-ext-install pdo_mysql && \
    #rm -rf /usr/include/gmp.h && \
    #ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu && \
    docker-php-ext-install gmp && \
    docker-php-ext-install pcntl

# Copy the php.ini, and config.php. Be sure to update the config.php file for your own environment.
ADD php.ini /usr/local/etc/php/
#ADD config.php /ipamscan/
WORKDIR /ipamscan
CMD php /ipamscan/index.php discover; php /ipamscan/index.php update
# A wise man once told me this line is required for this Image to work. I think his name was Gandalf The Grey and I trusted him at that time.
