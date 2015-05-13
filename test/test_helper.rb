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

  def self.add_cap_environment(name, env)
    %x[cd /tmp/#{name} && mkdir -p config/deploy && touch config/deploy/#{env}.rb && git add -A && git commit -m "Added env #{env}"]
  end

  def self.new_commit_and_tag(name, filename, msg, tag)
    %x[cd /tmp/#{name} && touch #{filename} && git add -A && git commit -m "#{msg}" && git tag -a #{tag} -m "#{msg}"]
  end

end
