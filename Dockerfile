FROM php:5.6-apache

# Instala dependências do sistema
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo 'Acquire::AllowInsecureRepositories "true";' > /etc/apt/apt.conf.d/allow-insecure \
    && echo 'Acquire::Check-Valid-Until "false";' >> /etc/apt/apt.conf.d/allow-insecure \
    && echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/allow-insecure \
    && apt-get update \
    && apt-get install --allow-unauthenticated -y \
        libpng-dev \
        libjpeg62-turbo-dev \
        libxml2-dev \
        zlib1g-dev \
        libicu-dev \
        locales \
        zip \
        unzip \
        curl \
        nano \
        libonig-dev \
        libxslt-dev \
        libzip-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libjpeg-dev \
        libfreetype6-dev \
        poppler-utils \
        ghostscript \
        gsfonts \
        iputils-ping \
        wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        exif \
        bcmath \
        gd \
        zip \
        intl \
        calendar \
        mysqli


RUN sed -i '/pt_BR.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen pt_BR.UTF-8

ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR:pt
ENV LC_ALL=pt_BR.UTF-8

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

EXPOSE 80

WORKDIR /var/www/html
