FROM ruby:2.5.1

# don't install gem documentation
RUN echo "gem: --no-rdoc --no-ri" > ~/.gemrc

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

# install plugin
COPY Gemfile Gemfile.lock drone_plugin.gemspec ./
RUN bundle install --without development test
COPY pkg/drone_plugin-0.0.1.gem /tmp
RUN gem install --no-ri --no-rdoc --local /tmp/drone_plugin-0.0.1.gem

# run the plugin
ENTRYPOINT ["drone_plugin"]
