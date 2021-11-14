# Surveilance

## Introduction

Imagine you have to build an app that checks every minute every person in the system to make sure the system is tracking everyone.

## Problem

Now imagine that at some point that system tracks 1000 different "actors" how would you run these checks?

This repo contains an initial approach and a second one using Sidekiq as entrypoint for each one check individually


## Running

Running the initial solution
```shell
ruby past.rb
```

Running the present solution

```shell
docker run --name surveillance-redis -p 6379:6379 -d redis
bundle exec sidekiq -r ./present.rb
```
