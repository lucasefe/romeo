FROM ruby:2.3-onbuild
ADD . /usr/src/app
RUN bundle install
CMD ["rackup", "-o", "0.0.0.0"]
EXPOSE 9292
