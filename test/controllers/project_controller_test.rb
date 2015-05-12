require 'test_helper'

class ProjectControllerTest < ActionController::TestCase

  test 'show info if no repos exist' do
    project = FactoryGirl.build(:project, key: 'pjt')
    project.save

    get :show, project: project.key

    assert_response :success
    assert_select '.messages', 1
    assert_select '.messages' do
      assert_select '.alert-info' do
        assert_select 'strong', "This project is yet to contain any repos."
      end
    end
  end

  test 'show no info if repos exist' do
    project = FactoryGirl.build(:project, key: 'pjt')
    repo = FactoryGirl.build(:repo)
    project.repos << repo
    repo.save
    project.save

    get :show, project: project.key

    assert_response :success
    assert_select '.messages', 0
  end

  test 'list repos' do
    project = FactoryGirl.build(:project, key: 'pjt')
    repo1 = FactoryGirl.build(:repo, name: 'R1', key: 'r1')
    repo2 = FactoryGirl.build(:repo, name: 'R2', key: 'r2')
    project.repos << repo1
    project.repos << repo2
    repo1.save
    repo2.save
    project.save

    get :show, project: project.key

    assert_response :success
    assert_select 'li.repo', 2
    assert_select 'ol.repos' do
      assert_select 'li.repo', "R1"
      assert_select 'li.repo', "R2"
    end

  end

end
