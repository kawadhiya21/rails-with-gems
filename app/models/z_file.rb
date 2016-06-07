class ZFile < ActiveRecord::Base
  belongs_to :user
  validates :user, :presence => true
  
  has_attached_file :file_hash
  validates :file_hash, :presence => true
  do_not_validate_attachment_file_type :file_hash
end
