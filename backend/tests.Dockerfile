FROM renderedtext/elixir-dev:1.13.3

ENV MIX_ENV test

RUN mix local.rebar

COPY ./mix.exs ./mix.lock ./

RUN mix local.hex --force
RUN mix deps.get --force
RUN mix deps.compile

COPY ./ ./mix.lock ./

EXPOSE 4000/tcp

CMD mix test
