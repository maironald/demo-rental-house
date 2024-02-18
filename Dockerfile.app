FROM ruby:3.2.2

ENV RACK_ENV=production
ENV RAILS_ENV=production

RUN apt-get update && \
    apt-get install apt-utils && \
    apt-get install -y cmake pkg-config

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn
RUN yarn add vite

# install cron
RUN apt-get install -y cron

# install ffmpeg & poppler
RUN apt-get install -y --no-install-recommends \
    ffmpeg \
    poppler-utils

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
COPY ./config/database.yml.sample /app/config/database.yml
COPY package.json yarn.lock /app/

RUN bundle config --local without 'development:test' && \
    bundle install --jobs 4 --retry 3 && \
    bundle clean --force && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

ENTRYPOINT ["docker/entrypoint.sh"]

EXPOSE 3000

CMD rails s -p 3000 -b 0.0.0.0
