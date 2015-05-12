require 'test_helper'

class ApiControllerTest < ActionController::TestCase

  test 'list no projects' do
    get :list_projects

    assert_response :success
    result = JSON.parse(response.body)

    assert_equal 0, result['projects'].count
  end

  test 'list all projects' do
    p1 = FactoryGirl.build(:project, name: 'POne')
    p2 = FactoryGirl.build(:project, name: 'PTwo')
    p1.save
    p2.save

    get :list_projects

    assert_response :success
    result = JSON.parse(response.body)

    assert_equal 2, result['projects'].count
    assert_equal 'POne', result['projects'].first['name']
    assert_equal 'PTwo', result['projects'].last['name']
  end

end
