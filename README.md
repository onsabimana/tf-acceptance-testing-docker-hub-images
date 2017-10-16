# terraform-acceptance-testing-docker-hub-images
Automatic build of terraform acceptance test container for Docker Hub

## What's included?

* Debian jessie
* Go 1.8.4
* Go dep (Google's sub-official dependancy management tool)
* Go dependencies for acceptance testing

## Usage

In order to use go dep as designed, we need include our dependencies in some go code (main.go), and lock any versions in the Gopkg.toml. Go dep automatically removes any unused dependencies, so we can't just add stuff in the Gopkg.toml file a la bundler.
