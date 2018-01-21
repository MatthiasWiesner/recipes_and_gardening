class Tag < ApplicationRecord
  has_many :recipe_tags
  has_many :recipes, :through => :recipe_tags

  has_many :gardening_tags
  has_many :gardenings, :through => :gardening_tags
end
