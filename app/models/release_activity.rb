class ReleaseActivity < ActiveRecord::Base
  has_one :release
  has_one :environment
end
