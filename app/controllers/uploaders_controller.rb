class UploadersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @files = current_user.z_files
    puts @files.inspect
    @file = ZFile.new
  end

  def create
    @file = current_user.z_files.create(file_params)
    if @file.save
      flash[:message] = "File saved successfully"
    else
      flash[:message] = "Could not save file due to some error"
    end
    redirect_to '/'
  end

  private
  def file_params
    puts params.inspect
    params.require(:z_file).permit(:file_hash)
  end

  public
  def show
    begin
      if current_user.role == 'admin'
        zfile = ZFile.find(params[:id])
      else
        zfile = current_user.z_files.find(params[:id])
      end
      send_file(zfile.file_hash.path, filename: zfile.file_hash.original_filename)
    rescue Exception => e
      render plain: "You don't have access to this file #{e.message}"
    end
  end
end
