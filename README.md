# Andruha API Gateway

## Purpose and current status

This repository contains the NGINX edge skeleton for Andruha Messenger. It currently provides routing declarations, request-ID ownership, safe access logs, and operational health endpoints only.

## Responsibility and non-responsibilities

The gateway owns public transport routing, upstream forwarding, WebSocket upgrade headers, timeouts, trusted request IDs, and mapping the HttpOnly `access_token` cookie into an internal `Authorization: Bearer` header. It intentionally overwrites any client-supplied `Authorization` header to prevent credentials spoofing. It does not validate JWTs, perform RBAC or session lookups, validate messenger domains, or implement business logic.

## Entrypoints

- `GET /health/live`
- `GET /health/ready`
- Future HTTP route prefixes under `/api/v1/`
- Future WebSocket upgrade route at `/ws`

The future routes are routing declarations only; their upstream business APIs are not implemented.

## Configuration

The image listens on port `8080`. Upstream hostnames are Docker Compose service names and are resolved through Docker DNS.

## Local build and run status

The multi-stage Dockerfile validates the NGINX configuration with `nginx -t`.
`.github/workflows/ci.yml` scans secrets, builds the validated runtime image,
and smoke-tests health, request-ID replacement, and JSON 404 behavior.
`.github/workflows/release.yml` publishes a verified image to GHCR only for a
version tag. The root Compose workflow also checks the gateway together with
the five runnable Python service images.

## Canonical project material

- [Documentation](https://github.com/yemeal/andruha-messenger/tree/main/docs)
- [Contracts](https://github.com/yemeal/andruha-messenger/tree/main/contracts)
