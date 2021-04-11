FROM node:14

RUN yarn global add caprover --prefix /usr/local

COPY run.sh /run.sh

ENTRYPOINT ["sh", "/run.sh"]