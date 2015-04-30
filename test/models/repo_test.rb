require 'test_helper'

class RepoTest < ActiveSupport::TestCase

  test 'make new repo initializes, saves and creates clone' do
    begin
      TestHelper.create_test_repo('test_repo')
      project = FactoryGirl.build(:project)

      repo = Repo.make('name', 'file:///tmp/test_repo', project)

      assert !repo.new_record? # it's been saved
      assert_equal project, repo.project
      assert_equal 'name', repo.name
      assert_equal '/tmp/test_project/test_repo', repo.path
      assert Dir.exist?('/tmp/test_project/test_repo')
      assert Dir.exist?('/tmp/test_project/test_repo/.git')
    ensure
      TestHelper.delete_test_repo('test_repo')
      TestHelper.delete_test_repo('test_project')
    end
  end

end
