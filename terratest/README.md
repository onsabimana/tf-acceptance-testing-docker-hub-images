# Terraform Acceptance Test Docker Image

Automatic build of terraform acceptance test container for
[Docker Hub](https://hub.docker.com/r/cozero/tf-acceptance-testing/).

## Current Containers

[![build status](https://img.shields.io/docker/build/cozero/tf-acceptance-testing.svg)](https://hub.docker.com/r/cozero/tf-acceptance-testing)

- Full list of tags at [dockerhub](https://hub.docker.com/r/cozero/tf-acceptance-testing/tags/)

## Synopsis

A container that uses [Terratest](https://github.com/gruntwork-io/terratest) by Gruntwork(https://www.gruntwork.io/) to test terraform modules.

## What's included?

- Debian stretch
- Go [1.10](https://golang.org/doc/go1.10).3
- [Terratest](https://github.com/gruntwork-io/terratest) source
- [Terraform](https://terraform.io) binary

## Usage

Modify the docker command below, noting in particular:

- AWS_PROFILE should be setup in your ~/.aws/credentials file and should be a
  test/dev account

- A valid TF_VERSION is one of the values defined for [TERRAFORM_VERSIONS](./terraform_versions)

```
docker run --rm \
  -e AWS_PROFILE=development \
  -v ~/.aws:/root/.aws \
  -v $(pwd):/go/src/app \
  cozero/tf-acceptance-testing:terratest-v${TF_VERSION} test -v -run ./...
```

An actual command would look as follow using TF_VERSION=0.11.7 :

```
docker run --rm \
  -e AWS_PROFILE=development \
  -v ~/.aws:/root/.aws \
  -v $(pwd):/go/src/app \
  cozero/tf-acceptance-testing:terratest-v0.11.7 test -v -run ./...
```

- or use aws-vault, run in server mode and remove the AWS stuff

```
docker run --rm \
  -v $(pwd):/go/src/app \
  cozero/tf-acceptance-testing:terratest-v${TF_VERSION} test -v -run ./...
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

To update the lock file, run the [godep](https://github.com/golang/dep) `ensure` command:

```
docker run --rm -v $(pwd):/go/src/app --entrypoint '' tf-acceptance-testing:latest dep ensure -v
```

Finally, commit the changes to Gopkg.lock and Gopkg.toml, update the
[CHANGELOG.md](./CHANGELOG.md) and create a Pull Request!
