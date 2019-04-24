class Play < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :reviews

  has_one_attached :play_img
end
