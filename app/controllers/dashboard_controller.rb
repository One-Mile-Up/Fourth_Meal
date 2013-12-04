class DashboardController < ApplicationController
  before_action :require_login, only: [:show]
  before_action :require_admin, only: [:show]

  def show
    @dashboard = Dashboard.new
  end
end
