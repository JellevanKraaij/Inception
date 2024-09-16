FROM alpine:3.19

WORKDIR /app
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN apk add --no-cache envsubst

RUN apk add --no-cache php82 php82-phar php82-fpm php82-mysqli php82-json php82-opcache php82-mbstring php82-xml php82-gd php82-curl

COPY tools/entrypoint.sh .
COPY conf/php-fpm.conf .

EXPOSE 9000

ENTRYPOINT [ "/app/entrypoint.sh" ]

CMD [ "php-fpm82", "-F", "-R" ]