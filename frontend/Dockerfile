FROM nginxinc/nginx-unprivileged:1.19-alpine

WORKDIR /app

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ./code/* ./

EXPOSE 8080