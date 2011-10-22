source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem 'devise'
gem 'cancan'

gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git'

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.6'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker'

  gem 'foreman', :require => false
end

group :production do
  gem 'pg'
  gem 'thin'
end
