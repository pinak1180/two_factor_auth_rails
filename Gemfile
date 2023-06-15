# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "bootsnap", require: false
gem "devise"
gem "devise-two-factor", "~> 5.0"
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.5"
gem "redis", "~> 4.0"
gem "rqrcode", "~> 2.2"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem "debug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "rspec-rails"
end
group :development do
  gem "web-console"
  gem "rubocop-shopify", require: false
end
group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
