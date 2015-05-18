class Release < ActiveRecord::Base
  belongs_to :repo
  has_many :release_activities
end
