# app/controllers/admin/dashboard_controller.rb
module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def index
      @tasks = Task.all
    end

    private

    def authorize_admin
      redirect_to root_path, alert: "Access denied!" unless current_user.admin?
    end
  end
end
