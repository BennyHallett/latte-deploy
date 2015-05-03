class Repo < ActiveRecord::Base
  belongs_to :project
  has_many :releases

  # TODO: What happens if we clone a thing that doesnt exist?

  def self.make(name, uri, project)
    me = Repo.create(name: name, uri: uri)
    project.repos << me
    project.save

    repo = LatteDeploy::Git.clone(me)
    repo.tags.each { |t| me.create_release(t.name) }

    me.path = LatteDeploy::Git.repo_path(me)
    me.save
    me
  end

  def key
    name.split(' ').map(&:downcase).join('_')
  end

  def create_release(name)
    release = Release.create(name: name)
    releases << release
    release.save
    save
  end

end
