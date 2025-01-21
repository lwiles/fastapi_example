FROM python:3.12.8-alpine3.21

# See: https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# Copy source code to "src" directory in Docker image
COPY . /src
WORKDIR /src

# Install uv (https://docs.astral.sh/uv/)
COPY --from=ghcr.io/astral-sh/uv:0.5.21 /uv /uvx /bin/

# Set up the venv using uv.lock file
RUN uv sync --frozen
# Upstart app using uv
CMD ["uv", "run", "fastapi", "run", "app/main.py", "--port", "80"]
