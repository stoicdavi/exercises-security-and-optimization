FROM docker:dind-rootless
WORKDIR /usr/src/app

COPY . .

ENTRYPOINT ["sh", "/usr/src/app/builder.sh"]