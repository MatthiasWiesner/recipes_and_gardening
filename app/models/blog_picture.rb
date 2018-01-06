class BlogPicture < ApplicationRecord
  belongs_to :blog
  belongs_to :picture
end
