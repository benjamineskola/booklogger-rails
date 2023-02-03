FROM ruby:3.2-alpine AS bundle

RUN apk --no-cache add build-base postgresql-dev
COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install
RUN rm -rf /usr/local/bundle/cache

FROM ruby:3.2-alpine AS yarn

WORKDIR /tmp/build

RUN apk --no-cache add postgresql-client libc6-compat
RUN apk --no-cache add yarn

RUN mkdir -p app
COPY package.json yarn.lock tsconfig.json ./
RUN yarn install

COPY . .
COPY --from=bundle /usr/local/bundle/ /usr/local/bundle/

RUN rails assets:precompile

FROM ruby:3.2-alpine AS main

WORKDIR /app

# libc6-compat needed for nokogiri :(
RUN apk --no-cache add postgresql-client libc6-compat

COPY . .
COPY --from=bundle /usr/local/bundle/ /usr/local/bundle/

FROM main AS prod

COPY --from=yarn /tmp/build/app/assets/builds app/assets/builds
COPY --from=yarn /tmp/build/public/assets public/assets

CMD rails s -b 0.0.0.0

FROM main AS dev

RUN apk --no-cache add yarn
COPY --from=yarn /tmp/build/node_modules node_modules

CMD bin/dev
