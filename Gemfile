source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.1"

# bundle config local.rails /Users/guochunzhong/git/oss/rails
gem "rails", "~> 7.2.1"

gem "propshaft"

# Use sqlite3 as the database for Active Record
gem "sqlite3"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma"

gem "shakapacker", "~> 8.0"

gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

gem "devise"
gem "devise-i18n"
gem "pundit"

gem "meta-tags"
gem "browser"

gem "config"

gem "ajax-datatables-rails"
gem "pagy"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]

  gem "standard"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Support cursor / vs code
  gem "ruby-lsp", require: false
  gem "ruby-lsp-rails", require: false

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-yarn"
  gem "capistrano-rbenv"
  gem "capistrano3-puma", ">= 6.0.0.beta.1"

  gem "ed25519"
  gem "bcrypt_pbkdf"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver", ">= 4.25.0"
end
