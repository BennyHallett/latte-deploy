class Environment < ActiveRecord::Base
  belongs_to :repo

  has_many :release_activities
  has_many :releases, through: :release_activities

  def status
    if release_activities.any?
      outcome = release_activities.last.outcome
      version = release_activities.last.release.name

      LatteDeploy::EnvironmentState.new(outcome, version)
    else
      LatteDeploy::EnvironmentState.unknown
    end
  end

end
