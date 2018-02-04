FROM ubuntu:16.04
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
  libapache2-mod-php7.0 \
  libmysqlclient-dev \
  mariadb-client \
  php7.0 \
  php-apcu \
  # php-apcu-bc \
  php7.0-cli \
  php7.0-curl \
  php7.0-gd \
  php7.0-imap \
  php7.0-json \
  php7.0-ldap \
  php7.0-mbstring \
  php7.0-mcrypt \
  php7.0-mysql \
  php7.0-opcache \
  php7.0-soap \
  # php-xdebug \
  php7.0-xml \
  php7.0-xmlrpc \
  php7.0-xsl \
  php7.0-zip

RUN a2enmod rewrite

# Clean-up, clean-up, everyone do your share...
RUN apt-get autoclean && apt-get -y autoremove

VOLUME ["/var/www"]
EXPOSE 80

CMD ["/var/www/docker-entrypoint.sh"]
