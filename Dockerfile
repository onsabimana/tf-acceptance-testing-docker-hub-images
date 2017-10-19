FROM golang:1.9.1
LABEL authors="Mat Baker <mbaker@cozero.com.au,Stuart Auld <sauld@cozero.com.au>"

ENV GOVENDOR_VERSION v1.0.8

RUN \
     go get -v -u github.com/kardianos/govendor \
  && cd $GOPATH/src/github.com/kardianos/govendor \
  && git checkout $GOVENDOR_VERSION

ENV TERRAFORM_VERSION 268138dbd49368dafe0af174bf1b8fe9c1812e53

WORKDIR $GOPATH/src/arrakis

COPY vendor.json $GOPATH/src/arrakis/vendor/vendor.json

RUN govendor sync

ENTRYPOINT ["go"]
