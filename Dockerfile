FROM erlang:22-alpine AS elvis
RUN apk --update add git build-base && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
RUN git clone https://github.com/inaka/elvis.git && \
    cd elvis && \
    rebar3 do compile, escriptize
# ------------------------------------------------------------------------------
FROM erlang:22-alpine

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ v0.9.13
RUN apk --update add git && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

COPY --from=elvis /elvis/_build/default/bin/elvis /usr/local/bin/elvis
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
