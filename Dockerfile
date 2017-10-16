# this is based on jessie
FROM golang:1.8.4
MAINTAINER Mat Baker <mbaker@cozero.com.au>

RUN \
     go get -u github.com/golang/dep/cmd/dep

COPY main.go Gopkg.lock Gopkg.toml $GOPATH/src/app/

WORKDIR $GOPATH/src/app

RUN \
     dep ensure

ENTRYPOINT ["go"]
