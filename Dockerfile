# syntax=docker/dockerfile:1

FROM python:3.9-slim-buster

LABEL org.opencontainers.image.source="https://github.com/daniel-beet/got-your-back-docker"

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR "/app"

COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt
COPY gyb.py .
COPY fmbox.py .
COPY labellang.py .
RUN chmod +x *.py

# Create a user (gyb) that has UID=1026 to avoid file permission issues later
ENV USER gyb
ENV UID=1026
ENV GID=100

RUN adduser \
    --disabled-password \
    --no-create-home \
    --gecos "" \
    --home "$(pwd)" \
    --uid "$UID" \
    --gid "$GID" \
    "$USER"
RUN chown -R ${USER} /app

USER ${USER}

VOLUME ["/data"]

WORKDIR "/data"

ENTRYPOINT ["/app/gyb.py"]

CMD ["--version"]
