class RepoController < ApplicationController

  def add
  end

  def create
    # TODO: Validation

    project = Project.find_or_create(params['project'])
    repo = Repo.make(params['name'], params['uri'], project)

    redirect_to show_repo_path(project.key, repo.key)
  end

end
