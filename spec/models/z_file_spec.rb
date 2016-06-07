require 'rails_helper'

RSpec.describe ZFile, :type => :model do
  before :each do
    @path = Dir.pwd + "/spec/fixtures/files/abc.pdf"
    FileUtils.touch(@path)
  end

  context "Empty Object" do
    it "should not save" do
      zfile = ZFile.new
      expect(zfile.save).to eq(false)
    end
  end

  context "File without owner" do
    it "should not save" do
      zfile = ZFile.new
      zfile.file_hash = File.new(@path)
      zfile.save
      expect(zfile.errors.full_messages.include? "User can't be blank").to eq(true)
    end
  end
end
