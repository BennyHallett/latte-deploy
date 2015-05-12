class ProjectController < ApplicationController

  def show
    @project = Project.find_by(key: params[:project])

    flash.now[:info] = "This project is yet to contain any repos." unless @project.repos.any?
  end

end
