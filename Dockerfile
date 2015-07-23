FROM ruby:2.2.0
ADD . ~/bbtv_data
WORKDIR ~/bbtv_data
ADD Gemfile ~/bbtv_data/Gemfile
RUN bundle install
ADD . ~/bbtv_data