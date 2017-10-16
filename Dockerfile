# this is based on jessie
FROM golang:1.8.4
MAINTAINER Mat Baker <mbaker@cozero.com.au>

ENV TEST_PROJECT_NAME arrakis

RUN \
     go get -v -u github.com/kardianos/govendor \
  && rm -rf vendor
  && mkdir -p /go/src/$TEST_PROJECT_NAME

WORKDIR $TEST_PROJECT_NAME

# currently this is the only known working commitish
# this terraform commit breaks 4acdc53a5646aef7fd1f5044ffb6c1380687344b acceptance testing
ENV TERRAFORM_VERSION d969f97e730d527a568a0929ce52df70e062bca0

RUN \
     govendor init \
  && govendor fetch -v +external \
  && govendor fetch -v +missing \
  && govendor fetch -v github.com/hashicorp/terraform/...@$TERRAFORM_VERSION

ENTRYPOINT ["go"]
