class Gardening < ApplicationRecord
  has_many :gardening_pictures
  has_many :pictures, :through => :gardening_pictures

  has_many :gardening_tags
  has_many :tags, :through => :gardening_tags
end
