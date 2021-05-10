source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'hotwire-rails'
gem 'image_processing'
gem 'jbuilder'
gem 'kaminari'
gem 'mysql2'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.0'
gem 'redis'
gem 'rexml'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'sorcery'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem "rubocop"
  gem "rubocop-rails_config"
  gem "rubocop-rspec"
end

group :development do
  gem 'flay'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'rspec-its'
  gem 'rspec-rails', '~> 5'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
