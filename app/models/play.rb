class Play < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :play_img
end
