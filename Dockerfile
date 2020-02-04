FROM jekyll/jekyll:3.8 AS builder

USER root
WORKDIR /code
COPY . /code
RUN touch Gemfile.lock \
  && chmod -R a+w . \
  && jekyll build

FROM nginx:1.17-alpine

COPY --from=builder /code/_site /usr/share/nginx/html