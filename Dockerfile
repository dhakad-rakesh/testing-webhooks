FROM public.ecr.aws/y1r6m5q0/gammastack-ruby:2.4.3

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y --force-yes nodejs git curl make postgresql-client bash ruby-dev build-essential yarn && \
  rm -rf /var/cache/apt/*

# Rails logger output to STDOUT only
ENV RAILS_LOG_TO_STDOUT=1

RUN mkdir /code

# set the app directory var
ENV APP_HOME /code
WORKDIR $APP_HOME

ENV RAILS_ENV production

# Install nodejs dependencies
COPY package.json $APP_HOME/
RUN npm install

# Install ruby dependencies
COPY Gemfile Gemfile.lock $APP_HOME/

#ENV BUNDLER_VERSION='2.1.4'
#RUN gem install bundler --version 2.1.4

ENV BUNDLER_VERSION='2.2.7'
RUN gem install bundler --version 2.2.7

ENV BUNDLER_WITHOUT development test
RUN BUNDLE_FORCE_RUBY_PLATFORM=1 bundle install

COPY . $APP_HOME/

RUN bundle exec rake assets:precompile

CMD puma -C config/puma.rb
