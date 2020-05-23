source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 6.0.0'
gem 'pg', '1.2.3'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'webpacker', '~> 4.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'devise-i18n'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 3.9'
end

group :development do
  gem 'rubocop', '~> 0.79.0', require: false
  gem 'rubocop-rails', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 3.29'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
