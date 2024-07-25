# Use the official Ruby image as the base image
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION
RUN gem install bundler
WORKDIR /rails_app
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install
COPY . ./
ENTRYPOINT ["./bin/docker-entrypoint.sh"]