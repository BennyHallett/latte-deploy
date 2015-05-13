class Repo < ActiveRecord::Base
  belongs_to :project
  has_many :releases
  has_many :environments

  # TODO: What happens if we clone a thing that doesnt exist?

  def self.make(name, uri, project)
    me = Repo.create(name: name, uri: uri)
    project.repos << me
    me.save
    project.save

    repo = LatteDeploy::Git.clone(me)
    repo.tags.each { |t| me.create_release(t.name) }

    repo_path = LatteDeploy::Git.repo_path(me)

    Dir.glob(repo_path + "/config/deploy/*").map { |p| File.basename(p, '.rb').capitalize }.each { |n| me.create_environment(n) }

    me.path = repo_path
    me.key = name.split(' ').map(&:downcase).join('_')
    me.save
    me
  end

  def create_release(name)
    release = Release.create(name: name)
    releases << release
    release.save
    save
  end

  def create_environment(name)
    env = Environment.create(name: name, version: 'Unknown')
    environments << env
    env.save
    save
  end

end
