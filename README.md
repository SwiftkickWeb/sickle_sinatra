# sickle (sinatra version)
A small app for pulling our monthly harvest logs to determine the wage balanced rate 

---
## Prerequisites
- A workable ruby dev environment (ideally using a version manager such as chruby, rvm, or rbenv)
- Install ruby-2.7.3 with either ruby-install (or rbenv or rva)
- bundler. If the bundler gem is not installed for ruby-2.7.3 in your environment, `gem install bundler`

---
## Included
- app.rb -> the main project file with all the routes
- a views folder -> contains the templates included via the :erb calls in app.rb, as well as layout.erb for the main page frame
- a public folder -> contains CSS, image assets, JS, and whatnot
- Gemfile -> so bundler knows what's up
- config.ru -> for deployment. Also lets us run `rackup` to quickly start up a server instead of running `ruby app.rb`. Not sure if there's a benefit. More info here: https://devcenter.heroku.com/articles/rack
