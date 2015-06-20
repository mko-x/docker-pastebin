FROM node
MAINTAINER Markus Kosmal <code@m-ko-x.de>

RUN git clone https://github.com/seejohnrun/haste-server.git /opt/haste
WORKDIR /opt/haste
RUN npm install

ADD conf/config.js /opt/haste/config.js

EXPOSE 80
CMD ["npm", "start"]