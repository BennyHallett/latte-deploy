class DashboardController < ApplicationController

  def index
    flash[:info] = "You haven't created a project yet." unless Project.count > 0

    @projects = Project.all
  end

end
