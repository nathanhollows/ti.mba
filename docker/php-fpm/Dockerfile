FROM php:7.2-fpm

# LABEL maintainer="MilesChou <github.com/MilesChou>, fizzka <github.com/fizzka>"
LABEL maintainer="nathanhollows <github.com/nathanhollows>"

ARG PSR_VERSION=1.1.0
ARG PHALCON_VERSION=4.1.2
ARG PHALCON_EXT_PATH=php7/64bits

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#  Run Composer
USER www-data
WORKDIR /var/www/html
USER root

# Set up cache and var directories
RUN mkdir  -p /var/www/html/var/{backup,logs,metaData,modelsCache,session,volt}
RUN chmod a+rwx /var/www/html/var/{backup,logs,metaData,modelsCache,session,volt}

# Install Phalcon
RUN set -xe && \
        # Download PSR, see https://github.com/jbboehr/php-psr
        curl -LO https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PSR_VERSION}.tar.gz && \
        # Download Phalcon
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PHALCON_VERSION}.tar.gz && \
        docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/cphalcon-${PHALCON_VERSION}/build/${PHALCON_EXT_PATH} \
        && \
        # Remove all temp files
        rm -r \
            ${PWD}/v${PSR_VERSION}.tar.gz \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/v${PHALCON_VERSION}.tar.gz \
            ${PWD}/cphalcon-${PHALCON_VERSION} \
        && \
        php -m

COPY docker-phalcon-* /usr/local/bin/
RUN docker-php-ext-install pdo_mysql

# Set working directory
WORKDIR /var/www/html/public

# Expose php-fpm port
EXPOSE 9000

# Start php-fpm
CMD ["php-fpm"]
