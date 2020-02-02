FROM ruby:latest

RUN apt-get update && \
		curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
		echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
		apt-get update && \
		apt-get install -y yarn && \
		gem install rails -v 6.0.2.1 && \
		echo "export RUBYOPT='-W:no-deprecated -W:no-experimental'" >> ~/.profile

EXPOSE 3000