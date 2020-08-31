# Real time blog backend example

## Quick start

Clone env_sample to .env for local development.

```
cp env_sample .env
```

Install the bundle:
```
bundle install
```

Make sure the postresql is running on localhost. You may have to change your credentials under /config/database.yml:

```
rake db:create
rake db:migrate
rake db:seed
```

Run the development server:

```
rails s
```

## Before commit
Set up overcommit to make sure your code is clean :) :

```bash
gem install overcommit
bundle install --gemfile=.overgems.rb
overcommit --install
```
Then you can commit your changes! And don't forget to run specs before:

```bash
bundle exec rspec
```

## Bibliography

I would like to thank [ZauberWare](https://www.zauberware.com) for the amazing boilerplate which helped me boost the development of core features of this app. Definitely, worth checking out: https://github.com/zauberware/rails-devise-graphql
