class ApiController < ApplicationController

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

    activity = ReleaseActivity.create(log: params['log'], outcome: params['outcome'], release_date: DateTime.now)
    release.release_activities << activity
    env.release_activities << activity

    release.save
    env.save
    activity.save

    render json: { status: 'success' }
  end

end
