FROM ruby:3.1.1

WORKDIR /subscribe_coding_challenge

COPY . .

RUN bundle install
