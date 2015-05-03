class DashboardController < ApplicationController

  def index
    flash.now[:info] = "You haven't created a project yet." unless Project.count > 0

    @projects = Project.all
  end

end
