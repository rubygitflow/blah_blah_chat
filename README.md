# blah_blah_chat
Demo App written in **Hotwire**

Here we can add topics and post messages.
**Stimulus** allows us to process quotes on a single page.
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

## Run tests
```bash
$ rspec spec
```

## Check syntax
```bash
$ rubocop
```
