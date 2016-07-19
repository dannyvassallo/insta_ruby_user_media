#Instagram Sinatra App

Auths in user and pulls recent media filtered by video type.

####Getting started

In the console:

```shell
git clone https://github.com/dannyvassallo/insta_ruby_user_media
cd insta_ruby_user_media
bundle install
```

In your editor:

Duplicate `.env.example`

Rename it to `.env`

On the web:

Goto [Instagram Developers](https://www.instagram.com/developer/) and get the appropriate keys.

Replace the '******' in `.env` with their corresponding keys.

Set your redirect_uri to `http://localhost:4567/oauth/callback`
in the dev panel on Instagram.

It should look like this while in development:

![alt text](https://s3-us-west-2.amazonaws.com/instascrape/instaexample.png "Example Image")

Back in the console:
```
ruby insta.rb
```
