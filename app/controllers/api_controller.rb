class ApiController < ApplicationController

  def list_projects
    projects = {
      projects: Project.all.map { |p| { name: p.name } }
    }

    render json: projects
  end

end
