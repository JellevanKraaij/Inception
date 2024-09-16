FROM alpine:3.19

WORKDIR /app

RUN apk add --no-cache envsubst
RUN apk add --no-cache mariadb mariadb-client
EXPOSE 3306

COPY tools/entrypoint.sh .
COPY tools/setup.sql .
COPY conf/my.cnf .

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "mariadbd", "--user=root", "--datadir=/var/lib/mysql" ]