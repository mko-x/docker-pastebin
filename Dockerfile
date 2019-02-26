FROM node:alpine
MAINTAINER Markus Kosmal <b@m-ko.de>

RUN apk --update add --no-cache git
RUN git clone https://github.com/seejohnrun/haste-server.git /opt/haste
WORKDIR /opt/haste
RUN rm /opt/haste/about.md
ADD conf/about.md /opt/haste/
RUN apk del git && npm install

ADD conf/config.js /opt/haste/config.js

VOLUME ["/opt/haste"]

EXPOSE 80
CMD ["npm", "start"]
