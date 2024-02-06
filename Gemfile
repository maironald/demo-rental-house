# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 7.0.6'
gem 'rails_seeds'
gem 'redis', '~> 4.0'
gem 'slim-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'vite_rails', '~> 3.0'
gem 'simple_form'
gem 'simple_form-tailwind'
gem 'devise'
gem 'rolify'
gem 'seedbank'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection', '~>1.0'
gem 'pagy'
gem 'cloudinary'
gem 'carrierwave'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'dotenv-rails'
end

group :development do
  gem 'annotate'
  gem 'bullet'
  gem 'lefthook'
  gem 'letter_opener'
  gem 'rack-mini-profiler'
  gem 'spring'
  gem 'web-console'
  gem 'htmlbeautifier'
  gem 'erb_lint', require: false
  gem 'better_html'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

gem "noticed", "~> 2.0"
