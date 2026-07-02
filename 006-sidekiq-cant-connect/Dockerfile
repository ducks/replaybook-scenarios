FROM ruby:3.3-alpine
RUN apk add --no-cache build-base
WORKDIR /app
COPY Gemfile .
RUN bundle install
COPY worker.rb run.sh ./
CMD ["sh", "/app/run.sh"]
