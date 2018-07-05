FROM ruby:2.5.1
RUN apt-get update && \
    apt-get install -y mysql-client nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /pomodoro
WORKDIR /pomodoro
ADD Gemfile /pomodoro/Gemfile
ADD Gemfile.lock /pomodoro/Gemfile.lock
RUN gem install bundler
RUN bundle install
ADD . /pomodoro
