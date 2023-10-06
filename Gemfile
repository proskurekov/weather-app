source 'https://rubygems.org'

ruby '2.7.2'

gem 'rails', '~> 7.1.0'

gem 'sprockets-rails'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# grape
gem 'grape', '~> 1.8'

# grape swagger
gem 'grape-swagger', '~> 1.6', '>= 1.6.1'

# env
gem 'dotenv', '~> 2.8', '>= 2.8.1'

# Oj
gem 'oj', '~> 3.16', '>= 3.16.1'

# fara
gem 'faraday', '~> 2.7'

group :development, :test do
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'rspec-rails', '~> 6.0'
end

group :test do
  gem 'airborne', '~> 0.0.18'
  gem 'rspec', '~> 3.12'
  gem 'rubocop', '~> 1.56', '>= 1.56.4'
  gem 'webmock'
end

group :development do
  gem 'web-console'
end
