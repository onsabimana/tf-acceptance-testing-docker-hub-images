FROM golang:1.10.3
LABEL authors="Mat Baker <mbaker@cozero.com.au,Stuart Auld <sauld@cozero.com.au>"

ARG TERRAFORM_VERSION

# Use dep to override dependencies based on our Gopkg.toml
ENV GOLANG_DEP_VERSION v0.4.1
ADD https://github.com/golang/dep/releases/download/$GOLANG_DEP_VERSION/dep-linux-amd64 /usr/bin/dep

RUN \
     apt-get update -y \
  && apt-get install -y zip \
  && chmod +x /usr/bin/dep \
  && mkdir -p $GOPATH/src/app \
  && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin \
  && rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR $GOPATH/src/app

COPY Gopkg.toml Gopkg.lock ./

RUN \
     dep ensure -v --vendor-only \
  && mv vendor/* /go/src

ENTRYPOINT ["go"]
