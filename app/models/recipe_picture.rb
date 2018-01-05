class RecipePicture < ApplicationRecord
  belongs_to :recipe
  belongs_to :picture
end
