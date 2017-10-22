# Terraform Acceptance Test Docker Image
Automatic build of terraform acceptance test container for (Docker Hub)[https://hub.docker.com/r/cozero/tf-acceptance-testing/]

## RTFM

Rather than rolling our own acceptance testing, we are utilising hashicorp's acceptance test tools as well as the existing interfaces in the terraform-provider-aws. So great (HT @mubaker)!

So, since we're basically dropping our tests in the middle of someone else's repo, you'll need to follow a couple of rules:

- tests must be in the aws package
- namespace pretty much everything with Arrakis to avoid conflicts. E.g. instead of testAccProviders, I used testAccArrakisProviders
- use Docker 17.06 or greater to enable single container mount support

## What's included?

* Debian jessie
* Go 1.9.1
* Go dep 0.3.1 (Google's sub-official dependancy management tool)
* terraform-provider-aws v1.1.0
* Go dependencies based on the Gopkg.lock file and the terraform-provier-aws/vendor folder

## Usage

If this container has everything you need for your tests, you're good to just

```
docker tag cozero/tf-acceptance-testing:latest gogo
docker run --rm \
  -e AWS_PROFILE=development \
  -e BUILDKITE_BRANCH=dev-buildskip \
  -e SSH_AUTH_SOCKET=$SSH_AUTH_SOCKET \
  -e TF_ACC=1 \
  -v ~/.aws:/root/.aws \
  -v ~/.ssh:/root/.ssh \
  $(for i in $(ls aws); do echo "--mount type=bind,source=$(pwd)/aws/${i},target=/go/src/github.com/terraform-providers/terraform-provider-aws/aws/${i}"; done) \
  gogo test -v -run Arrakis ./...


```
## Updating dependency versions

Add any new constraints to the Gopkg.toml file to your liking (RTFM)[https://github.com/golang/dep/blob/master/docs/Gopkg.toml.md]

Build the Gopkg.lock
```
docker build -t acctest .
```

Extract the new Gopkg.lock
```
Gopkg.lock < $(docker run --rm acctest echo Gopkg.lock)
```

Finally, commit the changes to Gopkg.lock and Gopkg.toml and PR!
