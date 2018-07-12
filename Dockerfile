FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https apt-utils

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app