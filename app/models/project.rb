class Project < ActiveRecord::Base
  has_many :repos

  def key
    name.split(' ').map(&:downcase).join('_')
  end

end
