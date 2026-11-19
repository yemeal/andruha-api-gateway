# syntax=docker/dockerfile:1
ARG NGINX_IMAGE=nginx:1.30.7-alpine3.24

FROM ${NGINX_IMAGE} AS validation

COPY nginx.conf /etc/nginx/nginx.conf
COPY proxy-common.conf /etc/nginx/proxy-common.conf
RUN nginx -t

FROM ${NGINX_IMAGE} AS runtime

COPY --from=validation /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=validation /etc/nginx/proxy-common.conf /etc/nginx/proxy-common.conf

EXPOSE 8080
USER nginx

CMD ["nginx", "-g", "daemon off;"]
