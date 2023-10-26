# Specify the correct version of Ruby
FROM ruby:3.0.6

# Create a directory for the application
WORKDIR /myapp

# Install bundler
RUN gem install bundler:2.3.7

# Installing gems
COPY Gemfile* /myapp/
RUN bundle config set --local without 'development test'
RUN bundle install

# Copying the application files into the container
COPY . /myapp/


# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
