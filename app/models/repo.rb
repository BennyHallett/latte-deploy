class Repo < ActiveRecord::Base
  belongs_to :project

  # TODO: What happens if we clone a thing that doesnt exist?

  def self.make(name, uri, project)
    me = Repo.create(name: name, uri: uri)
    project.repos << me
    project.save

    LatteDeploy::Git.clone(me)

    me.path = LatteDeploy::Git.repo_path(me)
    me.save
    me
  end

end
