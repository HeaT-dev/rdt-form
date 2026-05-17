FROM caddy:2.7-alpine

# Copy the static form into Caddy's web root
COPY index.html /usr/share/caddy/index.html

# Railway provides $PORT - serve on it (Caddy defaults to 80, we override)
ENV PORT=80
EXPOSE 80

# Use a minimal Caddyfile that listens on Railway's $PORT and serves static files
RUN echo ':${PORT} {' > /etc/caddy/Caddyfile && \
    echo '    root * /usr/share/caddy' >> /etc/caddy/Caddyfile && \
    echo '    file_server' >> /etc/caddy/Caddyfile && \
    echo '    encode gzip' >> /etc/caddy/Caddyfile && \
    echo '    header {' >> /etc/caddy/Caddyfile && \
    echo '        X-Content-Type-Options nosniff' >> /etc/caddy/Caddyfile && \
    echo '        X-Frame-Options DENY' >> /etc/caddy/Caddyfile && \
    echo '        Referrer-Policy strict-origin-when-cross-origin' >> /etc/caddy/Caddyfile && \
    echo '    }' >> /etc/caddy/Caddyfile && \
    echo '}' >> /etc/caddy/Caddyfile

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
