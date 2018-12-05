FROM ruby:2.5.3

RUN apt-get update && apt-get install graphviz -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev netcat curl apt-transport-https apt-utils

#RUN apt-get install -yq g++ libssl-dev apache2-utils git python make nano


# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev


# Add nodejs sources for 8.x install
RUN wget -qO - https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs




ENV INSTALL_PATH /application

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ENV BUNDLE_PATH /box

COPY . .
