FROM ruby:2.2.0
RUN apt-get update && apt-get install -y ruby ruby-dev
RUN gem install sinatra
ADD . ~/bbtv_data
WORKDIR ~/bbtv_data
ADD Gemfile ~/bbtv_data/Gemfile
RUN bundle install
ADD . ~/bbtv_data
ENV PORT 4567
EXPOSE 4567
CMD["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]