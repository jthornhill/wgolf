FROM library/ruby:3.1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Update system and Install extra packages
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    apt-get install -y nodejs \
                       yarn \
                       expect \
                       openssl \
                       less \
                       wget \
                       readline-common \
                       postgresql-common \
                       coreutils \
                       --no-install-recommends && \
    echo "" | /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh && \
    apt-get install -y postgresql-client-12 --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV TZ UTC
# Set up our docker user
RUN echo 'docker-user:x:1000:0:docker container user:/home/docker-user:/bin/bash' >> /etc/passwd
RUN mkdir -p ~docker-user && chown -R docker-user:0 ~docker-user && chmod g+w ~docker-user

RUN umask 0002; mkdir /app
COPY Gemfile /app/
COPY Gemfile.lock /app/
WORKDIR /app
# bundle does not respect the umask when run as a root user, sadly
RUN umask 0002 && \
    bundle config set deployment true &&\
    bundle config set no-document true &&\
    bundle config set without development &&\
    bundle install && \
    chmod -R g+w /app/vendor/bundle && \
    rm -rf /app/vendor/bundle/ruby/*/cache/* /app/vendor/bundle/ruby/*/gems/*/ext

COPY yarn.lock /app/
COPY package.json /app/
RUN umask 0002; bundle exec yarn install

# Now we get everything else in
COPY . /app

# Precompile our assets
RUN umask 0002; RAILS_ENV=production DATABASE_URL=postgresql://NODB@COMPILEME:5432 \
                bundle exec rails assets:precompile

# Set up dirs and permissions so we can run without root
RUN umask 0002; mkdir -p /app/tmp/pids /app/log /app/public/packs-test && \
    chmod g+w db/structure.sql || chmod g+w db/schema.rb || true

USER 1000:0

# Args used to provide metadata about the build which is displayed in the web ui
ARG CI_PIPELINE_URL=UNKNOWN
ARG CI_COMMIT_REF_NAME=UNKNOWN
ARG CI_COMMIT_SHA=UNKNOWN
ARG CI_BUILD_TIME=UNKNOWN

ENV CI_PIPELINE_URL=$CI_PIPELINE_URL \
    CI_COMMIT_REF_NAME=$CI_COMMIT_REF_NAME \
    CI_COMMIT_SHA=$CI_COMMIT_SHA \
    CI_BUILD_TIME=$CI_BUILD_TIME

CMD ["/app/bin/app-start"]
