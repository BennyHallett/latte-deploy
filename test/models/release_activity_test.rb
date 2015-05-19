require 'test_helper'

class ReleaseActivityTest < ActiveSupport::TestCase
  test "make release activity" do
    now = DateTime.now
    DateTime.expects(:now).returns(now)

    release = FactoryGirl.build(:release)
    environment = FactoryGirl.build(:environment)

    release.save
    environment.save

    log = 'This is the massive log lalala.'
    outcome = 'success'

    assert_equal 0, ReleaseActivity.count

    ReleaseActivity.make(outcome, log, release, environment)

    assert_equal 1, ReleaseActivity.count
    activity = ReleaseActivity.first

    assert_equal release.id, activity.release_id
    assert_equal environment.id, activity.environment_id
    assert_equal log, activity.log
    assert_equal outcome, activity.outcome
  end
end
