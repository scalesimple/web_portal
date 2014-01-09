source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'devise'
gem 'mongoid'
gem 'mongoid_rails_migrations', :git => 'https://github.com/stevef/mongoid_rails_migrations'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
#gem "twitter-bootstrap-rails"
gem 'kaminari'
gem 'net-dns'
gem 'bunny'
gem 'ipaddress'
gem 'unicorn'
gem 'exception_notification'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  #gem 'machinist_mongo' #, :require=>false #:require => 'machinist/mongoid' # or mongo_mapper
  gem 'faker'
  gem 'fakeweb'
  gem 'simplecov', :require => false
  gem "capistrano"
  gem 'rvm-capistrano'
  gem 'capistrano-unicorn', :require=>false
  gem "better_errors", ">= 0.7.2"
  gem "quiet_assets", ">= 1.0.2"
  gem "binding_of_caller", ">= 0.7.1"
end

group :test do

  gem 'machinist_mongo', :require => 'machinist/mongoid'
  gem 'debugger'

end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
