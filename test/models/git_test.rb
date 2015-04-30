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
      create_test_repo

      @repo.uri = 'file:///tmp/test_repo'
      LatteDeploy::Git.clone(@repo)

      assert Dir.exist?('/tmp/test_project/test_repo')
      assert Dir.exist?('/tmp/test_project/test_repo/.git')
    ensure
      delete_test_repo
    end
  end

  def create_test_repo
    %x[cd /tmp && mkdir test_repo && cd test_repo && git init]
  end

  def delete_test_repo
    %x[rm -rf /tmp/test_repo]
    %x[rm -rf /tmp/test_project]
  end



end
