require 'rails_helper'
require 'devise'

RSpec.describe UploadersController, type: :controller do
  login_user
  
  before :each do
    FileUtils.touch(Dir.pwd + "/spec/fixtures/files/abc.pdf")
    path = File.join("files/abc.pdf")
    @file = fixture_file_upload(path)
  end

  it "should be logged in" do
    expect(subject.current_user.class.name).to eq ("User")
  end

  describe "POST create" do
    it "should be able to upload file" do
      post :create, { :z_file => { :file_hash => @file }}
      expect(response).to redirect_to("/")
      expect(assigns(:file).file_hash.original_filename).to eq("abc.pdf")
    end
  end
  
  describe "GET index" do
    it "should see the uploaded files" do
      post :create, { :z_file => { :file_hash => @file }}
      post :create, { :z_file => { :file_hash => @file }}

      get :index
      expect(assigns(:files).length).to eq(2)
      expect(assigns(:files)[0].file_hash.original_filename).to eq("abc.pdf")
    end
  end

  describe "GET show" do
    it "should get the file it owns" do
      post :create, { :z_file => { :file_hash => @file }}
      fid = assigns(:file).id

      get :show, :id => fid
      expect(response.headers["Content-Disposition"]).to eq("attachment; filename=\"abc.pdf\"")
    end
  end
end
