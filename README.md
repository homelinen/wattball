# Wattball #

This is the code repository for the Wattball Project.

## Authors ##

## Installation ##

These instructions are for Linux, not sure if any relevance to Windows

1. Clone the repository into your working directory
2. cd into the newly created repo
3. Run `bundle install` which will download and install all of the gemfiles
   necessary to run the app.
4. Run `rake db:setup` to setup the development server and populate with some seed data.
6. Run `rails server` or `rails s` to run the application.
7. Visit localhost:3000
8. Login as `user@example.com` with password `changeme` to get access to
   everything.

## Checking Permissions ##

All the dummy users have the password `sekret` if you want to use those.

## Tests ##

1. Ensure the test database is initialised: `rake RAILS_ENV=test db:migrate`
2. Run rspec

Optionally you can install `rb-inotify` on Linux to use `guard` to automate the
test runs.

## Bug Tracker ##

[Redmine](http://redmine.homelinen.org) - For viewing tickets and bugs.

## Requirements ##

Ruby ~> 1.9.0 for paperclip
