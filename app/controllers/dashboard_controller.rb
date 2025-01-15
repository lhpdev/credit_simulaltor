class DashboardController < ApplicationController
  before_action :resume_session, only: [:show]

  def show
  end
end
