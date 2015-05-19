class ReleaseActivity < ActiveRecord::Base
  belongs_to :release
  belongs_to :environment

  def self.make(outcome, log, release, environment)
    me = ReleaseActivity.create(log: log, outcome: outcome, release_date: DateTime.now)
    release.release_activities << me
    environment.release_activities << me

    release.save
    environment.save
    me.save

    me
  end
end
