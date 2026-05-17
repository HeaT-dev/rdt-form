FROM caddy:2.7-alpine
COPY index.html /var/www/index.html
WORKDIR /var/www
EXPOSE 80
CMD ["sh", "-c", "caddy file-server --root /var/www --listen :${PORT:-80}"]
