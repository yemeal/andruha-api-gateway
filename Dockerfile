# syntax=docker/dockerfile:1
FROM nginx:1.28.0-alpine AS validation

COPY nginx.conf /etc/nginx/nginx.conf
COPY proxy-common.conf /etc/nginx/proxy-common.conf
RUN nginx -t

FROM nginx:1.28.0-alpine AS runtime

COPY --from=validation /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=validation /etc/nginx/proxy-common.conf /etc/nginx/proxy-common.conf

EXPOSE 8080
USER nginx

CMD ["nginx", "-g", "daemon off;"]
