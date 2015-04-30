require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "get key from name" do
    project = FactoryGirl.build(:project)
    assert_equal 'test_project', project.key
  end
end
