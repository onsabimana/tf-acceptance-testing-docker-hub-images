# terraform-acceptance-testing-docker-hub-images
Automatic build of terraform acceptance test container for Docker Hub

## What's included?

* Debian jessie
* Go 1.9.1
* Go dep 0.3.1 (Google's sub-official dependancy management tool)
* Go dependencies based on the Gopkg.lock file

## Updating dependencies

First, edit the Gopkg.toml file to your liking (RTFM)[https://github.com/golang/dep/blob/master/docs/Gopkg.toml.md]

Shell into the docker container

### Option A: build it yourself and update (slow)
```
docker build -t acceptance .
docker run --rm -it \
  --entrypoint /bin/bash \
  -v $(pwd):/go/src/arrakis/host \
  acceptance
```

### Option B: use the dockerhub container
```
docker run --rm -it \
  --entrypoint /bin/bash \
  -v $(pwd):/go/src/arrakis/host \
  cozero/tf-acceptance-testing
```

Then, update the Gopkg.lock file in this repo via one of the following options:-

```
cp host/Gopkg.toml ./
cp host/hello.go ./
dep ensure -v
cp Gopkg.lock host/
```

Finally, commit the changes to Gopkg.lock and Gopkg.toml and PR!

## Usage

I'm currently building a second dockerfile

```
FROM cozero/tf-acceptance-testing
LABEL authors="Mat Baker <mbaker@cozero.com.au>,Stuart Auld <sauld@cozero.com.au>"

COPY tests $GOPATH/src/arrakis

RUN dep ensure

ENTRYPOINT ["go"]

CMD ["test", "-v"]
```

Note: this dockerfile will only work for packages named "arrakis"
