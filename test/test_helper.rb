ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/setup'
require 'factory_girl'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class TestHelper

  def self.create_test_repo(name)
    %x[cd /tmp && mkdir #{name} && cd #{name} && git init]
  end

  def self.delete_test_repo(name)
    %x[rm -rf /tmp/#{name}]
  end

end
