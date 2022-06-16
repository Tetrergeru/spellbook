FROM elixir:1.13.2-alpine

ENV MIX_ENV dev

RUN mkdir /app
WORKDIR /app

RUN mix local.rebar

COPY ./mix.exs ./mix.lock /app/

RUN mix local.hex --force
RUN mix deps.get --force
RUN mix deps.compile

COPY ./ ./mix.lock /app/

EXPOSE 4000/tcp

CMD mix phx.server
