# Andruha API Gateway

## Purpose and current status

This repository contains the NGINX edge skeleton for Andruha Messenger. It currently provides routing declarations, request-ID ownership, safe access logs, and operational health endpoints only.

## Responsibility and non-responsibilities

The gateway owns public transport routing, upstream forwarding, WebSocket upgrade headers, timeouts, and trusted request IDs. It does not validate JWTs, perform RBAC or session lookups, validate messenger domains, or implement business logic.

## Entrypoints

- `GET /health/live`
- `GET /health/ready`
- Future HTTP route prefixes under `/api/v1/`
- Future WebSocket upgrade route at `/ws`

The future routes are routing declarations only; their upstream business APIs are not implemented.

## Configuration

The image listens on port `8080`. Upstream hostnames are Docker Compose service names and are resolved through Docker DNS.

## Local build and run status

The multi-stage Dockerfile validates the NGINX configuration with `nginx -t`. End-to-end startup is deferred until the Python service dependency-bootstrap task is complete.

## Canonical project material

- [Documentation](../../docs/)
- [Contracts](../../contracts/)
