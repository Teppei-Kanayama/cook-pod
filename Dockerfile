FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /cook_pod
COPY Gemfile /cook_pod/Gemfile
COPY Gemfile.lock /cook_pod/Gemfile.lock
RUN bundle install
COPY . /cook_pod

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001

# Start the main process.
CMD ["rails", "server", "-p", "3001", "-b", "0.0.0.0"]
