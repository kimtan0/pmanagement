class Complaint < ApplicationRecord
  has_one_attached :complaint_image

  def complaint_image_path
    ActiveStorage::Blob.service.path_for(complaint_image.key)
  end

end
