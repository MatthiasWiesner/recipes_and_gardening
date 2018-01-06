class Blog < ApplicationRecord
  has_many :blog_pictures
  has_many :pictures, :through => :blog_pictures
end
