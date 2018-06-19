FROM docker-hub.registry.integ.fr.auchan.com/nginx:1.10.2-alpine

COPY . /usr/share/nginx/html
EXPOSE 80
