require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase

  test "status with no release_activities" do
    env = FactoryGirl.build(:environment)

    assert_equal 'info', env.status.status
    assert_equal 'Unknown.', env.status.text
  end

  test "status with latest success release activity" do
    env = FactoryGirl.build(:environment)
    release = FactoryGirl.build(:release)
    failed = FactoryGirl.build(:release_activity, outcome: 'failed')
    success = FactoryGirl.build(:release_activity)

    release.release_activities << failed << success
    env.release_activities << failed << success

    assert_equal 'success', env.status.status
    assert_equal 'v1.0', env.status.text
  end

  test "status with latest failed release activity" do
    env = FactoryGirl.build(:environment)
    release = FactoryGirl.build(:release)
    failed = FactoryGirl.build(:release_activity, outcome: 'failed')
    success = FactoryGirl.build(:release_activity)

    release.release_activities << success << failed
    env.release_activities << success << failed

    assert_equal 'danger', env.status.status
    assert_equal 'v1.0', env.status.text

  end

end
