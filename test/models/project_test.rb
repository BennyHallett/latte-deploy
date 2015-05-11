require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "get key from name" do
    project = FactoryGirl.build(:project)
    assert_equal 'test_project', project.key
  end

  test "create a new project if it doesn't exist" do
    assert_equal 0, Project.count

    p = Project.find_or_create('NewProject')

    assert_equal 1, Project.count
    assert_equal 'NewProject', p.name
    assert_equal 0, p.repos.count
  end

  test "find a project by name if it exists" do
    project = FactoryGirl.build(:project, name: 'SampleProject')
    project.save

    assert_equal 1, Project.count

    p = Project.find_or_create('SampleProject')

    assert_equal 1, Project.count
    assert_equal project.name, p.name
  end

end
