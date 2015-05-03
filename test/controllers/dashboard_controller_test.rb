require 'test_helper'

class DashboardControllerTest < ActionController::TestCase

  test 'should show message when no projects exist' do
    get :index

    assert_response :success
    assert_select '.messages', 1
    assert_select '.messages' do
      assert_select '.alert-info' do
        assert_select 'strong', "You haven't created a project yet."
      end
    end
  end

  test 'should not show message when project exists' do
    project = FactoryGirl.build(:project)
    project.save

    get :index

    assert_response :success
    assert_select '.messages', 0
  end

  test 'should show project and repos when one exists' do
    project = FactoryGirl.build(:project)
    repo1 = FactoryGirl.build(:repo, name: 'repo_one')
    repo2 = FactoryGirl.build(:repo, name: 'repo_two')
    project.repos << repo1
    project.repos << repo2
    repo1.save
    repo2.save
    project.save

    get :index

    assert_response :success
    assert_select '.projects' do
      assert_select '.project', 1
      assert_select '.project' do
        assert_select 'h3', project.name

        assert_select '.repo', 2
        assert_select 'h4', repo1.name
        assert_select 'h4', repo2.name
      end
    end
  end

end
