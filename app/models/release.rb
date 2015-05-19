class Release < ActiveRecord::Base
  belongs_to :repo

  has_many :release_activities
  has_many :environments, through: :release_activities
end
