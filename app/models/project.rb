class Project < ActiveRecord::Base
  has_many :repos

  def self.find_or_create(name)
    # TODO: Want an index on name
    found = Project.find_by(name: name)
    return found if found

    Project.create(name: name)
  end

  def key
    name.split(' ').map(&:downcase).join('_')
  end

end
