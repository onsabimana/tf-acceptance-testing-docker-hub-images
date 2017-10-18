FROM golang:1.9.1
LABEL authors="Mat Baker <mbaker@cozero.com.au,Stuart Auld <sauld@cozero.com.au>"

# Golang/dep advise NOT to use master in production.
ENV GOLANG_DEP_VERSION v0.3.1
RUN \
     go get -u github.com/golang/dep/cmd/dep \
  && cd $GOPATH/src/github.com/golang/dep \
  && git checkout $GOLANG_DEP_VERSION

COPY Gopkg.lock Gopkg.toml $GOPATH/src/arrakis/

WORKDIR $GOPATH/src/arrakis

RUN dep ensure -v -vendor-only

ENTRYPOINT ["go"]
