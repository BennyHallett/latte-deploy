require 'test_helper'

class RepoControllerTest < ActionController::TestCase

  test 'form contents' do
    get :add
    assert_response :success

    assert_select 'input[name="project"]', 1
    assert_select 'input[name="name"]', 1
    assert_select 'input[name="uri"]', 1
  end

  test 'post add repo form' do
    begin
      TestHelper.create_test_repo 'new_repo'
      post :create, project: 'New Project', name: 'Something', uri: 'file:///tmp/new_repo'

      assert_redirected_to show_repo_path('new_project', 'something')
      assert_equal Project.count, 1
      assert_equal 'New Project', Project.first.name
      assert_equal Repo.count, 1
      assert_equal 'Something', Repo.first.name
    ensure
      TestHelper.delete_test_repo 'new_repo'
      TestHelper.delete_test_repo 'new_project'
    end
  end

  test 'show warning if no environments exist' do
    project = FactoryGirl.build(:project)
    repo = FactoryGirl.build(:repo, key: 'test_repo')
    project.repos << repo
    project.save
    repo.save

    get :show, project: project.key, repo: repo.key

    assert_response :success
    assert_select '.messages', 1
    assert_select '.messages' do
      assert_select '.alert-warning' do
        assert_select 'strong', "This repo doesn't appear to be a Capistrano project."
      end
    end
  end

  test 'show no warning if environments exist' do
    project = FactoryGirl.build(:project)
    repo = FactoryGirl.build(:repo, key: 'test_repo')
    env = FactoryGirl.build(:environment)
    project.repos << repo
    repo.environments << env
    project.save
    repo.save
    env.save

    get :show, project: project.key, repo: repo.key

    assert_response :success
    assert_select '.messages', 0
  end

  test 'show environments when they exist' do
    project = FactoryGirl.build(:project)
    repo = FactoryGirl.build(:repo, key: 'test_repo')
    staging = FactoryGirl.build(:environment, name: 'Staging')
    prod = FactoryGirl.build(:environment, name: 'Production')
    old_release = FactoryGirl.build(:release, name: 'v1.2.0')
    new_release = FactoryGirl.build(:release, name: 'v1.2.4')
    prod_activity = FactoryGirl.build(:release_activity, outcome: 'success')
    staging_activity = FactoryGirl.build(:release_activity, outcome: 'success')

    project.repos << repo

    repo.releases << old_release << new_release
    repo.environments << staging << prod

    old_release.release_activities << prod_activity
    new_release.release_activities << staging_activity
    staging.release_activities << staging_activity
    prod.release_activities << prod_activity

    [project, repo, staging, prod, old_release, new_release, prod_activity, staging_activity].each { |o| o.save }

    get :show, project: project.key, repo: repo.key

    assert_response :success
    assert_select '.environments', 1
    assert_select '.environment', 2
    assert_select '.environments' do
      assert_select 'p', 'Production'
      assert_select 'strong', 'v1.2.0'
      assert_select 'p', 'Staging'
      assert_select 'strong', 'v1.2.4'
    end
  end

end
