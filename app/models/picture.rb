class Picture < ApplicationRecord
  has_many :recipe_pictures
  has_many :recipes, :through => :recipe_pictures
  
  has_many :gardening_pictures
  has_many :gardening, :through => :gardening_pictures

  has_many :blog_pictures
  has_many :blog, :through => :blog_pictures
end
