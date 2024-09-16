FROM alpine:3.19

WORKDIR /app
RUN apk add --no-cache openssl
RUN apk add --no-cache envsubst
RUN apk add --no-cache nginx
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log
COPY tools/entrypoint.sh .
COPY conf/nginx.conf .

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]