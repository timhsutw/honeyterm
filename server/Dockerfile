FROM ruby:2.2.2

# Add an unprivileged user
RUN adduser --disabled-login --system --gecos 'ShowTerm' showterm

# Install dependencies
RUN apt-get update \
  && apt-get -y install nodejs \
  && apt-get clean

RUN mkdir /srv/showterm \
  && chown -R showterm /srv/showterm
RUN mkdir -p /srv/showterm/tmp/cache \
  && chmod 777 /srv/showterm/tmp \
  && chmod 777 /srv/showterm/tmp/cache
RUN mkdir -p /srv/init

WORKDIR /srv/showterm
ADD Gemfile /srv/showterm/Gemfile
ADD Gemfile.lock /srv/showterm/Gemfile.lock

RUN bundle install --path=$(pwd)

# Insert shorterm source
ADD . /srv/showterm

# Set DB config & do DB init / seed
RUN cp config/database.yml.example config/database.yml \
  && bundle exec rake db:create db:migrate db:seed \
  && cp /var/showterm/showterm.sqlite3 ./showterm.sqlite3 \
  && chown -R showterm /var/showterm

RUN touch /srv/showterm/log/development.log \
  && chmod 666 /srv/showterm/log/development.log
RUN touch /srv/showterm/log/skylight.log \
  && chmod 666 /srv/showterm/log/skylight.log

EXPOSE 3000
VOLUME ["/var/showterm"]
ENTRYPOINT ["/srv/showterm/docker-entrypoint.sh"]
