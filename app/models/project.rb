class Project < ActiveRecord::Base
  has_many :repos

  def self.find_or_create(name)
    # TODO: Want an index on name
    found = Project.find_by(name: name)
    return found if found

    project_key = name.split(' ').map(&:downcase).join('_')
    Project.create(name: name, key: project_key)
  end

end
