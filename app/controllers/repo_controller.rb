class RepoController < ApplicationController

  def add
  end

  def create
    # TODO: Validation

    project = Project.find_or_create(params['project'])
    repo = Repo.make(params['name'], params['uri'], project)

    redirect_to show_repo_path(project.key, repo.key)
  end

  def show
    project = Project.find_by(key: params['project'])
    @repo = project.repos.find_by(key: params['repo'])

    flash.now['warning'] = "This repo doesn't appear to be a Capistrano project." unless @repo.environments.any?
  end

end
