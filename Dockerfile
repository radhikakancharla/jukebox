# DEVELOPMENT DOCKERFILE

FROM ruby:2.4.1

RUN apt-get update && apt-get install vim postgresql-client redis-tools cifs-utils -y

RUN gem install rails

RUN cd /usr/local                                                        \
    && wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz  \
    && tar -xvf node-v8.4.0-linux-x64.tar.xz                             \
    && mv node-v8.4.0-linux-x64 node                                     \
    && rm node-v8.4.0-linux-x64.tar.xz

ENV PATH "/usr/local/node/bin:$PATH"
ENV PORT "3333"
ENV HOST "0.0.0.0"
ENV RAILS_ENV "development"

RUN npm i -g yarn
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install
ENV RAILS_SERVE_STATIC_FILES "true"
ENV SECRET_KEY_BASE "2b00555ad30e8fbdc71385bcfa9c745058dff1c12dc50c46c8df681ae204d3871e6692efbf8fc96b304a96e69327ca6d9076359995659da5f8da3ed30fb83e04"
RUN rails assets:clobber && rails assets:precompile


EXPOSE 3333
CMD ["rails", "server"]