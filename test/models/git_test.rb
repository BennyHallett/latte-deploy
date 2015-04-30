require 'test_helper'

class GitTest < ActiveSupport::TestCase

  setup do
    @repo = FactoryGirl.build(:repo)
    @project = FactoryGirl.build(:project)
    @project.repos << @repo
  end

  # TODO: Projects should gen a key: snake case
  # TODO: key should be unique

  test 'build repo_path' do
    #base is /tmp
    assert_equal '/tmp/test_project/repo', LatteDeploy::Git.repo_path(@repo)
  end

  test 'repo is cloned' do
    begin
      TestHelper.create_test_repo('test_repo')

      @repo.uri = 'file:///tmp/test_repo'
      LatteDeploy::Git.clone(@repo)

      assert Dir.exist?('/tmp/test_project/test_repo')
      assert Dir.exist?('/tmp/test_project/test_repo/.git')
    ensure
      TestHelper.delete_test_repo('test_repo')
      TestHelper.delete_test_repo('test_project')
    end
  end

end
