class AdminController < ApplicationController
  before_filter :authenticate_user!
  def admin_area
    @users = User.all
  end

  def show
    user = User.find(params[:id])
    @files = user.z_files
  end
end
