# terraform-acceptance-testing-docker-hub-images
Automatic build of terraform acceptance test container for Docker Hub

## What's included?

* Debian jessie
* Go 1.9.1
* Go dep 0.3.1 (Google's sub-official dependancy management tool)
* Go dependencies based on the Gopkg.lock file

## Updating dependency versions

First, edit the Gopkg.toml file to your liking (RTFM)[https://github.com/golang/dep/blob/master/docs/Gopkg.toml.md]
AND/OR add your go code with new imports to the tests folder

Download the cache from s3
```
export AWS_PROFILE=development
aws s3 sync s3://cozero-arrakis-acceptance-test-vendor-cache/ vendor/
```

Update the Gopkg.lock
```
docker run --rm -it \
  --entrypoint '' \
  -v ($pwd):/go/src/arrakis \
  cozero/tf-acceptance-testing dep ensure -v
```

Sync the cache back to s3
```
aws s3 sync vendor/ s3://cozero-arrakis-acceptance-test-vendor-cache/
```

Finally, commit the changes to Gopkg.lock and Gopkg.toml and PR!

## Usage

If this container has everything you need for your tests, you're good to just

```
docker run --rm \
  -e TF_ACC=1 \
  -v $(pwd)/tests:/go/src/arrakis/tests \
  cozero/tf-acceptance-testing test -v ./...
```

Otherwise, you'll need to build another container with an updated vendor cache and run it
```
FROM cozero/tf-acceptance-testing
LABEL authors="Mat Baker <mbaker@cozero.com.au>,Stuart Auld <sauld@cozero.com.au>"

COPY tests $GOPATH/src/arrakis

RUN dep ensure -v

ENTRYPOINT ["go"]

CMD ["test", "-v"]
```
