# Terraform Acceptance Test Docker Image

Automatic build of terraform acceptance test container for
[Docker Hub](https://hub.docker.com/r/cozero/tf-acceptance-testing/).

## Current Containers

[![tf-acceptance-testing:v0.11.7 build status](https://img.shields.io/docker/build/cozero/tf-acceptance-testing.svg)](https://hub.docker.com/r/cozero/tf-acceptance-testing)

- Full list of tags at [dockerhub](https://hub.docker.com/r/cozero/tf-acceptance-testing/tags/)

### Hashicorp Terraform

Built from the official [hashicorp/terraform](https://github.com/hashicorp/terraform) repository.

- cozero/tf-acceptance-testing:v0.11.7-p1
- cozero/tf-acceptance-testing:v0.11.7
- cozero/tf-acceptance-testing:v0.11.6
- cozero/tf-acceptance-testing:v0.11.3
- cozero/tf-acceptance-testing:v0.11.1
- cozero/tf-acceptance-testing:v0.11.0
- cozero/tf-acceptance-testing:v0.10.8
- cozero/tf-acceptance-testing:v0.10.7

### COzero Terraform

COzero is a contributor to terraform and sometimes has needs for referencing the [cozero/terraform](https://github.com/cozero/terraform) repository instead of
the official [hashicorp/terraform](https://github.com/hashicorp/terraform) one.

- cozero/tf-acceptance-testing:v0.11.3-cz7
- cozero/tf-acceptance-testing:v0.11.3-cz6
- cozero/tf-acceptance-testing:v0.11.3-cz5
- cozero/tf-acceptance-testing:v0.11.3-cz4
- cozero/tf-acceptance-testing:v0.11.3-cz3
- cozero/tf-acceptance-testing:v0.11.3-cz2
- cozero/tf-acceptance-testing:v0.11.3-cz

### Other Terraform ?

_We should probably note why we have these amongst others in our docker tag
listing or :knife: them._

- cozero/tf-acceptance-testing:v0.11.2-s2
- cozero/tf-acceptance-testing:v0.11.2-s

## RTFM

Rather than rolling our own acceptance testing, we are utilising hashicorp's
acceptance test tools as well as the existing interfaces in the
[terraform-provider-aws](https://github.com/terraform-providers/terraform-provider-aws/).
So great (HT @mubaker)!

So, since we're basically dropping our tests in the middle of someone else's
repo, you'll need to follow a couple of rules:

- tests must be in the aws package
- namespace pretty much everything with Arrakis to avoid conflicts. E.g. instead
  of testAccProviders, I used testAccArrakisProviders
- mount your modules to (e.g.) /config and refer there in the test config

## What's included?

- Debian stretch
- Go [1.10](https://golang.org/doc/go1.10).1
- [terraform-provider-archive](http://github.com/terraform-providers/terraform-provider-archive)
- [terraform-provider-aws](https://github.com/terraform-providers/terraform-provider-aws/)
- [terraform-provider-buildkite](https://github.com/cozero/terraform-provider-buildkite)
- [terraform-provider-grafana](https://github.com/terraform-providers/terraform-provider-grafana)
- [terraform-provider-github](https://github.com/terraform-providers/terraform-provider-github)
- [terraform-provider-pagerduty](https://github.com/terraform-providers/terraform-provider-pagerduty/)
- [terraform-provider-random](https://github.com/terraform-providers/terraform-provider-random/)
- [terraform-provider-template](https://github.com/terraform-providers/terraform-provider-template/)

## Usage

Modify the docker command below, noting in particular:

- AWS_PROFILE should be setup in your ~/.aws/credentials file and should be a
  test/dev account
- You can select a specific version of the acceptance tests to test against
  using the docker tag

```
docker run --rm \
  -e ARRAKIS_SOURCE_DIRECTORY=/config \
  -e AWS_PROFILE=development \
  -e TF_ACC=1 \
  -v ~/.aws:/root/.aws \
  -v $(pwd):/config \
  $(for i in $(ls aws); do echo "--mount type=bind,source=$(pwd)/aws/${i},target=/go/src/github.com/terraform-providers/terraform-provider-aws/aws/${i}"; done) \
  cozero/tf-acceptance-testing:v0.11.6 test -v -run Arrakis ./aws/
```

- or use aws-vault, run in server mode and remove the AWS stuff

```
docker run --rm \
  -e ARRAKIS_SOURCE_DIRECTORY=/config \
  -e TF_ACC=1 \
  -v $(pwd):/config \
  $(for i in $(ls tests); do echo "--mount type=bind,source=$(pwd)/tests/${i},target=/go/src/github.com/terraform-providers/terraform-provider-aws/aws/${i}"; done) \
```

## Updating dependency versions

Prerequisites:

- [Docker](https://www.docker.com/)

Add any new constraints to the Gopkg.toml file to your liking
(ref: [the manual](https://github.com/golang/dep/blob/master/docs/Gopkg.toml.md))

Build the container:

```
docker build . -t tf-acceptance-testing
```

To update the lock file, you'll first need to get onto the machine:

```
docker run --rm -it -v $(pwd):/go/src/app --entrypoint '' tf-acceptance-testing:latest /bin/bash
```

Then run the [godep](https://github.com/golang/dep) `ensure` command:

```
dep ensure -v
```

Finally, commit the changes to Gopkg.lock and Gopkg.toml, update the
[CHANGELOG.md](./CHANGELOG.md) and create a Pull Request!
