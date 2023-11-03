# Simple containerised version of got-your-back: GMail backup/restore script

Version of Got-Your-Back with a few extras (see help) - source version only.

Fork of https://github.com/jay0lee/got-your-back

# How to Run

## Version

Default command.

`docker run --rm gyb`

## Help

`docker run --rm gyb --help`

## Initial authentication

Initial setup requires an interactive console and terminal.

`docker run --rm -it -v <local-data-path>:/data gyb --action count --email <your-email>@gmail.com`

## Daily incremental backup

`docker run --rm -v <local-data-path>:/data gyb --action backup --email <your-email>@gmail.com --zip --noninteractive --fast-incremental`

## Regular clearout of deleted messages

`docker run --rm -v <local-data-path>:/data gyb --action backup --email <your-email>@gmail.com --zip --noninteractive --fast-incremental --remove-deleted`

## Less regular update of message labels

`docker run --rm -v <local-data-path>:/data gyb --action backup --email <your-email>@gmail.com --zip --noninteractive`

## Purge remote deleted messages from local database

`docker run --rm -v <local-data-path>:/data gyb --action backup --email <yout-email>@gmail.com --zip --noninteractive --fast-incremental --remove-deleted --purge-deleted`

# Build

Uses context from a clone of the GYB repo (or your own custom version).

## No cache build to ensure we have latest

`cd <path to got-your-back git repo>/got-your-back && docker build --rm --pull -f "<path to code>/gyb-docker/Dockerfile" --no-cache -t "gyb:latest" .`

## Build with caching

`cd <path to got-your-back git repo>/got-your-back && docker build --rm --pull -f "<path to code>/gyb-docker/Dockerfile" -t "gyb:latest" .`

## Push to Docker Hub

See https://hub.docker.com/repository/docker/ionicblue/gyb/tags?page=1&ordering=last_updated

`docker login`
`docker push ionicblue/gyb:latest`
