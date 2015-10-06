# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rack_session_access/capybara'

OmniAuth.config.test_mode = true
  omniauth_hash = { 'provider' => 'github',
                    'uid' => '12345',
                    'info' => {
                        'name' => 'sophie',
                        'email' => 'hi@sophie.com',
                        'nickname' => 'sophie'
                    },
                    'extra' => {'raw_info' =>
                                    { 'location' => 'New York',
                                      'gravatar_id' => '123456789'
                                    }
                    }
  }
 
OmniAuth.config.add_mock(:github, omniauth_hash)


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/*.rb")].each { |f| require f }
# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "default"
  config.include Capybara::DSL

  DatabaseCleaner.strategy = :truncation

  config.after(:all) do
    DatabaseCleaner.clean
  end
end
