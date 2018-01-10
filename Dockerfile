FROM golang:1.9.2
LABEL authors="Mat Baker <mbaker@cozero.com.au,Stuart Auld <sauld@cozero.com.au>"

# Use dep to override dependencies based on our Gopkg.toml
# Warning: using master until v0.3.3 is released!
ENV GOLANG_DEP_VERSION master
RUN \
     go get -u github.com/golang/dep/cmd/dep \
  && cd $GOPATH/src/github.com/golang/dep \
  && git checkout $GOLANG_DEP_VERSION \
# create our app folder
  && mkdir -p $GOPATH/src/app

WORKDIR $GOPATH/src/app

COPY hello Gopkg.toml Gopkg.lock ./

RUN dep ensure -v

ENTRYPOINT ["go"]
