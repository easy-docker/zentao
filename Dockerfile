FROM ubuntu:16.04
MAINTAINER yidong <yidong@cnezsoft.com>

RUN apt-get update && apt-get install -y apache2 php php-curl php-gd php-ldap php-mbstring php-mcrypt php-mysql php-xml php-zip php-cli php-json curl unzip libapache2-mod-php locales

ENV LANG="en_US.UTF8"
RUN echo -e "LANG=\"en_US.UTF-8\"\nLANGUAGE=\"en_US:en\"" > /etc/default/locale && locale-gen en_US.UTF-8

RUN mkdir -p /app/zentaopms
COPY docker-entrypoint.sh /app
RUN chmod 777 /app/docker-entrypoint.sh
RUN curl http://dl.cnezsoft.com/zentao/12.3/ZenTaoPMS.12.3.stable.zip?i=1 -o /var/www/zentao.zip
RUN cd /var/www/ && unzip -q zentao.zip && rm zentao.zip
RUN a2enmod rewrite

RUN rm -rf /etc/apache2/sites-enabled/000-default.conf
RUN sed -i '1i ServerName 127.0.0.1' /etc/apache2/apache2.conf
COPY config/apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY config/ioncube_loader_lin_7.0.so /usr/lib/php/20151012/ioncube_loader_lin_7.0.so
COPY config/00-ioncube.ini /etc/php/7.0/apache2/conf.d/
COPY config/00-ioncube.ini /etc/php/7.0/cli/conf.d/

VOLUME /app/zentaopms

ENTRYPOINT ["/app/docker-entrypoint.sh"]
