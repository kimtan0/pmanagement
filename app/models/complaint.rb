class Complaint < ApplicationRecord
  has_one_attached :complaint_image

  belongs_to :unit
end
