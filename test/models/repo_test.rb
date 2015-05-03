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

  test 'make new repo gets tags' do
    begin
      TestHelper.create_test_repo('aaaa')
      TestHelper.new_commit_and_tag('aaaa', 'test_file.txt', 'Testing a thing', 'v1.0')
      TestHelper.new_commit_and_tag('aaaa', 'test_file_2.txt', 'Testing another thing', 'v1.1')
      project = FactoryGirl.build(:project)

      repo = Repo.make('proj', 'file:///tmp/aaaa', project)

      assert_equal 2, repo.releases.count
      assert_equal 'v1.0', repo.releases.first.name
      assert_equal 'v1.1', repo.releases.last.name
    ensure
      TestHelper.delete_test_repo 'aaaa'
      TestHelper.delete_test_repo 'test_project'
    end
  end

end
