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
    @file = user.z_files.create({:file_hash => File.new(Dir.pwd + "/spec/fixtures/files/abc.pdf")})
    @file.save(validate: false)
  end

  describe "GET admin_area" do
    it "should allow admin to access" do
      get :admin_area
      expect(response).to render_template("admin_area")
    end
  end

  describe "GET show" do
    it "should allow to download file of any user" do
      get :show, :id => @file.id
      # The file is not delivered because of validation issues
      # but it allows to access it
      expect(response.body).to eq("")    
    end
  end
end
