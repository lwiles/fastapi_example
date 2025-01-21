FROM python:3.12.8-alpine3.21 AS full
COPY --from=ghcr.io/astral-sh/uv:0.5.21 /uv /uvx /bin/

# See: https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk update && \
    apk add --no-cache curl

COPY . /src
WORKDIR /src

RUN uv sync --frozen
CMD ["uv", "run", "fastapi", "run", "app/main.py", "--port", "80"]
