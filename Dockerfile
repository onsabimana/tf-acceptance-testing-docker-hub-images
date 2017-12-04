FROM golang:1.9.2
LABEL authors="Mat Baker <mbaker@cozero.com.au,Stuart Auld <sauld@cozero.com.au>"

# Use dep to override dependencies based on our Gopkg.toml
# Warning: using master until v0.3.3 is released!
ENV GOLANG_DEP_VERSION master
RUN \
     go get -u github.com/golang/dep/cmd/dep \
  && cd $GOPATH/src/github.com/golang/dep \
  && git checkout $GOLANG_DEP_VERSION

# We're going to impregnate our tests in the terraform-provider-aws package
RUN \
     go get -u github.com/terraform-providers/terraform-provider-aws/aws

WORKDIR $GOPATH/src/github.com/terraform-providers/terraform-provider-aws

ENV TF_PROVIDER_AWS_VERSION v1.5.0
RUN git checkout $TF_PROVIDER_AWS_VERSION

COPY Gopkg.toml Gopkg.lock ./

RUN dep ensure -v

ENTRYPOINT ["go"]
