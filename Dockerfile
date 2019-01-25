FROM    ubuntu:18.04
MAINTAINER      Simon "simon.xu.4au@gmail.com"

RUN apt-get update && apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ruby \
        nodejs npm \
        sqlite3 redis \
	      build-essential \ 
        curl locales
RUN npm install --global yarn

# For native gems
RUN apt-get install -y ruby-dev
# For native gem: nokogiri
RUN apt-get install -y libz-dev
# For native gem: sqlite3
RUN apt-get install -y libsqlite3-dev
# For native gem: pg
RUN apt-get install -y libpq-dev

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8 
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler
RUN bundle config --global silence_root_warning 1
RUN bundle install --jobs 20 --retry 5

# Copy the main application.
# COPY . ./

# Configure an entry point, so we don't need to specify 
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
CMD ["rails", "server", "-b", "0.0.0.0"]
