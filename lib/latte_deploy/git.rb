require 'git'

class LatteDeploy::Git

  def self.clone(repo)
    Git.clone(repo.uri, repo_path(repo))
  end

  def self.repo_path(repo)
    repo_part = repo.uri.split('/').last.split('.')
    repo_part.pop unless repo_part.length == 1
    repo_part = repo_part.join(".")

    File.join(Rails.configuration.repo_path, repo.project.key, repo_part)
  end

end
