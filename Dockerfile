# use the official Ruby image for version 2.5.3
FROM ruby:2.5.3

# update system and install Linux packages you need
RUN apt-get update

# define the directory that we want to use
WORKDIR /workspace

# install Bundler
RUN gem install bundler -v 2.2.27
