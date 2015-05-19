class ApiController < ApplicationController

  protect_from_forgery with: :null_session

  def list_projects
    projects = {
      projects: Project.all.map { |p| { name: p.name } }
    }

    render json: projects
  end

  def add_activity
    project = Project.find_by(key: params["project"])
    repo = project.repos.find_by(key: params['repo'])
    release = repo.releases.find_by(name: params['release'])
    env = repo.environments.find_by(name: params['environment'])

    ReleaseActivity.make(params['outcome'], params['log'], release, env)

    render json: { status: 'success' }
  end

end
