FROM golang:1.9.3
LABEL authors="Mat Baker <mbaker@cozero.com.au,Stuart Auld <sauld@cozero.com.au>"

# Use dep to override dependencies based on our Gopkg.toml
ENV GOLANG_DEP_VERSION v0.4.1
ADD https://github.com/golang/dep/releases/download/$GOLANG_DEP_VERSION/dep-linux-amd64 /usr/bin/dep

RUN \
     chmod +x /usr/bin/dep \
  && mkdir -p $GOPATH/src/app

WORKDIR $GOPATH/src/app

COPY Gopkg.lock ./

RUN \
  dep ensure -v --vendor-only

ENTRYPOINT ["go"]
