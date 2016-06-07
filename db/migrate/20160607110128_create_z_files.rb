class CreateZFiles < ActiveRecord::Migration
  def change
    create_table :z_files do |t|
      t.belongs_to :user,  index: true
      t.timestamps null: false
    end
  end
end
