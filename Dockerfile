FROM ruby:3.2.2-alpine

RUN apk update && apk upgrade

RUN apk add --update --no-cache build-base nodejs tzdata libpq-dev bash

RUN mkdir /app
WORKDIR /app

COPY . /app

COPY Gemfile Gemfile.lock app/

RUN gem update --system

RUN bundle install
