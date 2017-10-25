# Terraform Acceptance Test Docker Image
Automatic build of terraform acceptance test container for (Docker Hub)[https://hub.docker.com/r/cozero/tf-acceptance-testing/]

## RTFM

Rather than rolling our own acceptance testing, we are utilising hashicorp's acceptance test tools as well as the existing interfaces in the terraform-provider-aws. So great (HT @mubaker)!

So, since we're basically dropping our tests in the middle of someone else's repo, you'll need to follow a couple of rules:

- tests must be in the aws package
- namespace pretty much everything with Arrakis to avoid conflicts. E.g. instead of testAccProviders, I used testAccArrakisProviders
- mount your modules to (e.g.) /config and refer there in the test config

## What's included?

* Debian jessie
* Go 1.9.1
* Go dep 0.3.1 (Google's sub-official dependancy management tool)
* terraform-provider-aws v1.1.0
* Go dependencies based on the Gopkg.lock file and the terraform-provier-aws/vendor folder

## Usage

Modify the docker command below, noting in particular:
* AWS_PROFILE should be setup in your ~/.aws/credentials file and should be a test/dev account
* You can select a specific version of the acceptance tests to test against using the docker tag
```
docker run --rm \
  -e ARRAKIS_SOURCE_DIRECTORY=/config \
  -e AWS_PROFILE=development \
  -e TF_ACC=1 \
  -v ~/.aws:/root/.aws \
  -v $(pwd):/config \
  $(for i in $(ls aws); do echo "--mount type=bind,source=$(pwd)/aws/${i},target=/go/src/github.com/terraform-providers/terraform-provider-aws/aws/${i}"; done) \
  cozero/tf-acceptance-testing:v0.10.8 test -v -run Arrakis ./aws/
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
