# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'rspec/autorun'
require 'capybara/rspec'
require 'factory_girl_rails'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'simplecov'
require 'codeclimate-test-reporter'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

# Generate coverage report
SimpleCov.formatter = CodeClimate::TestReporter::Formatter if ENV['CIRCLE_ARTIFACTS']
SimpleCov.start 'rails'

# FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
# FactoryGirl.find_definitions

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Include FactoryGirl helper methods
  config.include FactoryGirl::Syntax::Methods

  # config.before(:all) do
  #   FactoryGirl.reload
  # end

  # Include SessionHelper methods
  #config.include Features::SessionHelpers, type: :feature
  FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]

  config.infer_spec_type_from_file_location!
  config.include Devise::TestHelpers, type: :controller
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.raise_errors_for_deprecations!

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Set up Capybara
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app)
  end
  Capybara.javascript_driver = :poltergeist
  Capybara.server_port = 5000

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end