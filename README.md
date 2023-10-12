# blah_blah_chat
Demo App with Hotwire

Here you can add topics and post messages.

## Setup
Configure the database in `config/database.yml`
```bash
$ rails db:setup
```

## Run the App
```bash
$ rails s
```
Open the app `http://localhost:3000 ` in the browser

## API
```bash
$ http -f get ":3000/api/v1/chats"
$ http -f post ":3000/api/v1/chats/1/posts" "post[body]=New message"
```

## Run tests
```bash
$ rspec spec
```

## Check syntax
```bash
$ rubocop
```
