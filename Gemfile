source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

gem 'pg', '~> 1.2'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

gem 'dry-validation'
gem 'trailblazer'
gem 'trailblazer-rails'

gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'brakeman'
  gem 'byebug'
  gem 'rubocop', require: false
  gem 'rubocop-checkstyle_formatter', require: false
end
