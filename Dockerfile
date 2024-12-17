FROM ruby:3.2.2-alpine

RUN apk update && apk upgrade

RUN apk add geckodriver --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

RUN apk add --update --no-cache build-base tzdata libpq-dev bash firefox

RUN mkdir /app
WORKDIR /app

COPY . /app

COPY Gemfile* app/

COPY docker-entrypoint.sh ./app

RUN gem update --system

RUN bundle install

EXPOSE 3000

RUN ["chmod", "+x", "/app/docker-entrypoint.sh"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
