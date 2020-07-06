source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem "aws-sdk-s3", require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'pg', '1.2.3'
gem 'puma', '~> 3.12'
gem 'rails', '~> 6.0.0'
gem 'sass-rails', '~> 5'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 3.9'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.79.0', require: false
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 3.29'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
