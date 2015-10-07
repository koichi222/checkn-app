source 'https://rubygems.org'
ruby "2.2.1"


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use mysql as the database for Active Record
gem 'mysql2', group: [:development, :test]
gem 'pg', group: [:staging1, :production]

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass', '~> 3.3.4'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
gem 'unicorn', '~> 4.8.3'

gem 'dalli'

gem 'rack-contrib'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rest-client', '~> 1.8.0'
gem 'kaminari', '~> 0.16.3'
gem "simple_calendar", "~> 1.1.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'

  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4'
  gem 'guard'
end

group :staging1, :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm', '~> 3.11.1.284'
  gem 'le' # https://logentries.com/app/91cd6052#/add-log/ruby
end