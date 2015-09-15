source 'https://rubygems.org'
source 'https://ruby.taobao.org'
ruby '2.1.2'
gem 'rails', '4.2.4'
gem 'sqlite3'
gem 'sass-rails', '~> 5.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'compass-rails', github: 'Compass/compass-rails', branch: '2-0-stable'

gem 'figaro'
gem 'sendgrid'
gem 'simple_form'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby
gem 'foundation-rails'
gem 'materialize-sass'

# Client side validation
gem 'jquery-validation-rails'

# i18n
gem 'rails-i18n', '~> 4.0.0'
gem 'devise-i18n'
gem 'devise-i18n-views'

# Authorization and Authority
gem 'devise'
gem 'devise_invitable'
gem 'cancancan', '~> 1.7'
gem 'rolify'
#gem 'pundit'

# For sns login
gem 'omniauth-weibo-oauth2'
gem "omniauth-wechat-oauth2"

gem 'weibo2'
gem 'oauth'
gem 'oauth_china' #Send message to sns platform

# For user custom message
gem 'mailboxer'

# For upload picture
gem 'carrierwave'
#gem 'remotipart', '~> 1.2'
gem 'jquery.fileupload-rails'
gem 'mini_magick'

gem 'state_machine'

# Admin panel
gem 'rails_admin'

# city selection
gem 'china_city'
# map selection
gem "geocoder"

#gem 'rmagick', :require=>false

gem "simple_calendar"

gem 'will_paginate', '~> 3.0'

# Forum engine integrate
gem 'forem', :github => "radar/forem", :branch => "rails4"
gem 'forem-foundation', :github => "decode/forem-foundation"

gem 'mysql2', "~> 0.3.13"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'#, :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'haml-rails'
  gem 'haml2slim'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

gem 'puma'

group :development, :test do
  gem 'factory_girl_rails'
end

group :test do
  #gem 'capybara'
  #gem 'minitest-spec-rails'
  #gem 'minitest-wscolor'
end
