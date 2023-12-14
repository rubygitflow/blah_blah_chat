# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '>= 7.1.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
# gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '>= 1.5.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 6.4.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails', '>= 1.2.3'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '>= 1.5.0'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '>= 1.3.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 5.0.8'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails', '>= 1.3.3'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails', '>= 1.2.1'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft', '~> 0.8.0'

# Executes code after database commit wherever you want in your application [https://github.com/Envek/after_commit_everywhere]
gem 'after_commit_everywhere', '>= 1.3.1'

gem 'bootstrap_icons_rails', '>= 1.91.01'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails', '>= 6.4.2'
  gem 'faker', '>= 3.2.2'
  gem 'rspec-rails', '~> 6.1'
  gem 'rubocop', '~> 1.58', require: false
  gem 'rubocop-rspec', '~> 2.25', require: false
  gem 'shoulda-matchers', '~> 5.3'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara', '~> 3.39'
  gem 'database_cleaner', '~> 2.0'
  gem 'rails-controller-testing', '>= 1.0.5'
  gem 'selenium-webdriver', '~> 4.15'
  gem 'simplecov', '~> 0.22.0', require: false
end
