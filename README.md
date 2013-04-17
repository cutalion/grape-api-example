API
===

# System Requirements

* ruby 1.9.3
* see Gemfile

# Installation

* `bundle install`
* `rake db:migrate db:test:prepare`
* `rake db:seed`
* `rspec spec`

# Development

* Run console: `racksh`
* Generate migration file: `rake g:migration NAME=migration_name`
* All ActiveRecord rake tasks are accessible: `db:migrate`, `db:drop`, `db:seed`, etc
* Start the server: `rackup`

# Heroku

[This code on heroku](https://grape-api-example.herokuapp.com/)
Use this `special-key` in /api/doc swagger interface: `e711541a4a79b037c15a8b01314d667e`
