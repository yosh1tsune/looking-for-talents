FROM ruby:3.2.2-alpine

RUN apk update && apk upgrade

RUN apk add --update --no-cache build-base nodejs yarn  tzdata libpq-dev bash chromium chromium-chromedriver

RUN mkdir /app
WORKDIR /app

COPY . /app

COPY Gemfile Gemfile.lock app/

RUN gem update --system

RUN yarn install --check-files

RUN bundle install
