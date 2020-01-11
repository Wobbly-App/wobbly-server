FROM elixir:alpine

COPY .dependabot /wobbly/
COPY config /wobbly/
COPY lib /wobbly/
COPY test /wobbly/
COPY *.exs /wobbly/

WORKDIR /wobbly/

RUN apk --update upgrade && \
    apk add  \
        build-base  \
        gd-dev  \
        libjpeg-turbo-dev  \
        libpng-dev  \
        libwebp-dev  \
        openssl-dev  \
        yaml-dev  \
        expat-dev  \
    && rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

RUN mix

CMD [ "iex", "-S", "mix"]