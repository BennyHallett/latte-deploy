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

  test 'add activity to repo' do
    now = DateTime.now

    DateTime.expects(:now).returns(now)

    project = FactoryGirl.build(:project, key: 'pj')
    repo = FactoryGirl.build(:repo, key: 'rp')
    environment = FactoryGirl.build(:environment, name: 'Prod')
    release = FactoryGirl.build(:release, name: 'v1.1')

    project.repos << repo
    repo.environments << environment
    repo.releases << release

    project.save
    repo.save
    environment.save
    release.save

    assert_equal 0, ReleaseActivity.count

    post :add_activity, project: 'pj', repo: 'rp', release: 'v1.1', environment: 'Prod', outcome: 'success', log: 'This is the log.'

    assert_response :success
    result = JSON.parse(response.body)
    assert_equal 'success', result['status']

    assert_equal 1, ReleaseActivity.count
    activity = ReleaseActivity.first
    assert_equal environment.id, activity.environment_id
    assert_equal release.id, activity.release_id
    assert_equal 'success', activity.outcome
    assert_equal 'This is the log.', activity.log
    assert_equal now.utc.strftime("%d/%m/%y %H:%M:%S"), activity.release_date.strftime("%d/%m/%y %H:%M:%S")
  end

end
