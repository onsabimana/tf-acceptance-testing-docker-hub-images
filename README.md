# terraform-acceptance-testing-docker-hub-images
Automatic build of terraform acceptance test container for Docker Hub

## What's included?

* Debian jessie
* Go 1.9.1
* Govendor 1.0.8
* Go dependencies based on vendor.json file

## Updating dependencies

?

## Usage

If this container has everything you need for your tests, you're good to just

```
docker run --rm \
  -e BUILDKITE_COMMIT=$BUILDKITE_COMMIT \
  -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
  -e TF_ACC=1 \
  -v $(pwd)/tests:/go/src/arrakis/tests \
  -v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) \
  -v /var/lib/buildkite-agent/.ssh/known_hosts:/root/.ssh/known_hosts:ro \
  cozero/tf-acceptance-testing test -v ./...
```

Otherwise, you'll need to build another container with an updated vendor cache and run it
```
FROM cozero/tf-acceptance-testing
LABEL authors="Mat Baker <mbaker@cozero.com.au>,Stuart Auld <sauld@cozero.com.au>"

COPY tests $GOPATH/src/arrakis

RUN \
     govendor fetch -v +missing

ENTRYPOINT ["go"]

CMD ["test", "-v"]
```
