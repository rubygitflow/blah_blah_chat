# blah_blah_chat

[![Tests](https://github.com/rubygitflow/blah-blah-chat/actions/workflows/ci.yml/badge.svg)](https://github.com/rubygitflow/blah-blah-chat/actions)

Demo App written in **Hotwire**

Here we can add topics and post messages.
**Stimulus** allows us to process posts on a single page.
**Turbo** allows us to monitor the changes from any chat in real time.

## Setup
Configure the database in `config/database.yml`
```bash
$ rails db:setup
```
or install all yarn and database dependencies with one command
```bash
$ bin/setup
```

## Run the App
```bash
$ rails s
```
or in dev environment
```bash
$ bin/dev
```
Open the app `http://localhost:3000 ` in the browser

## API
```bash
$ http -f get ":3000/api/v1/chats"
$ http -f post ":3000/api/v1/chats/1/posts" "post[body]=New message"
$ http -f post ":3000/api/v1/chats/1/posts" "post[body]=New message" "highlight="
```
More details can be found in `/blah-blah-chat-api-spec.jst` or in [JSight API repository](https://editor.jsight.io/r/gjoyG6J/1) .

## Run tests
```bash
$ rspec ./spec
```
or
```bash
HEADLESS=true rspec ./spec
```
or
```bash
HEADLESS=1 rspec ./spec
```

## Check syntax
```bash
$ rubocop
```

## Create docker image
```bash
$ docker build . -t blah-blah-chat:1.1
```

## Run docker container
```bash
$ docker compose up
```

## Look at Health monitoring
```bash
$ watch -n1 docker ps
```

## Run application from docker container
`localhost:3322`
