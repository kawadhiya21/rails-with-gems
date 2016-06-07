require 'rails_helper'
require 'devise'

RSpec.describe AdminController, type: :controller do
  login_user

  before :each do
    @user = User.new
    @user.email = "asdf@dfdf.com"
    @user.password = "asdf1234"
    @user.save

    user = subject.current_user
    user.update_attribute(:role, "admin")
  end

  describe "GET admin_area" do
    it "should allow admin to access" do
      get :admin_area
      expect(response).to render_template("admin_area")
    end
  end
end
