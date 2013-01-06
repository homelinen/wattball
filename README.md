# Wattball #

This is the code repository for the Wattball Project.

## Authors ##

## Installation ##

These instructions are for Linux, not sure if any relevance to Windows

1. Clone the repository into your working directory
2. cd into the newly created repo
3. Run `bundle install` which will download and install all of the gemfiles
   necessary to run the app.
4. Run `rake db:migrate` to setup a blank development database in the `db/`
   folder.
5. Run `rails server` or `rails s` to run the application.
6. Visit localhost:3000

## Dummy Data ##

To generate dummy data look at the `rake -T dummy` tasks.

## Requirements ##

Ruby ~> 1.9.0 for paperclip
