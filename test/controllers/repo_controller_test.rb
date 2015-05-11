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

end
