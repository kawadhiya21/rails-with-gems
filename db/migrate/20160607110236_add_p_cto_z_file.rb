class AddPCtoZFile < ActiveRecord::Migration
  def up
    add_attachment :z_files, :file_hash
  end

  def down
    remove_attachment :z_files, :file_hash
  end
end
