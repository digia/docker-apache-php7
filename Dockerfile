FROM ubuntu:17.04
MAINTAINER Jonathon Moore <jon@digia.io>

# Suppress
ENV DEBIAN_FRONTEND noninteractive

# init. apt update & install common
RUN apt-get update && apt-get install -y \
  apt-utils \
  curl \
  zip \
  unzip \
  vim \
  locales \
  software-properties-common \
  python-software-properties

# Set up locales
RUN locale-gen en_US.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
RUN /usr/sbin/update-locale

RUN apt-get update && apt-get install -y \
  --no-install-recommends --allow-remove-essential --allow-change-held-packages \
  apache2 \
  libapache2-mod-php \
  libmysqlclient-dev \
  mariadb-client \
  php \
  php-apcu \
  php-apcu-bc \
  php-cli \
  php-curl \
  php-gd \
  php-imap \
  php-json \
  php-ldap \
  php-mbstring \
  php-mcrypt \
  php-mysql \
  php-opcache \
  php-soap \
  php-xdebug \
  php-xml \
  php-xmlrpc \
  php-xsl \
  php-zip

RUN a2enmod rewrite

# Clean-up, clean-up, everyone do your share...
RUN apt-get autoclean && apt-get -y autoremove

VOLUME ["/var/www"]
EXPOSE 80

CMD ["/var/www/docker-entrypoint.sh"]
