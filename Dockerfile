# syntax=docker/dockerfile:1

FROM python:3.9-slim-buster

LABEL org.opencontainers.image.source="https://github.com/daniel-beet/got-your-back-docker"

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Trick GYB into storing data in the docker volume. Make sure it ends in '/'
ENV STATICX_PROG_PATH=/data/

WORKDIR "/app"

COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt
COPY gyb.py .
COPY fmbox.py .
COPY labellang.py .
RUN chmod +x *.py

# Create a user (gyb) that has UID=1000 to avoid file permission issues later
ENV user gyb
RUN useradd -m -d /home/${user} -u 1000 ${user} \
    && chown -R ${user} /home/${user} \
    && chown -R ${user} /app

USER ${user}

VOLUME ["/data"]

WORKDIR "/data"

ENTRYPOINT ["/app/gyb.py"]

CMD ["--version"]
