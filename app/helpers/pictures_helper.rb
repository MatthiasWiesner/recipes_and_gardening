module PicturesHelper
  def destroy_picture(picture_id)
    RecipePicture.where(picture_id: picture_id).destroy_all
    GardeningPicture.where(picture_id: picture_id).destroy_all
    BlogPicture.where(picture_id: picture_id).destroy_all
    Picture.find(picture_id).destroy
  end

  def destroy_gardening_pictures(gardening_id)
    GardeningPicture.where(gardening_id: gardening_id).destroy_all
    destroy_orphans
  end

  def destroy_recipe_pictures(recipe_id)
    RecipePicture.where(recipe_id: recipe_id).destroy_all
    destroy_orphans
  end

  def destroy_blog_pictures(blog_id)
    BlogPicture.where(blog_id: blog_id).destroy_all
    destroy_orphans
  end

  def destroy_orphans
    Picture.all.each do |picture|
      next if RecipePicture.where(picture_id: picture.id).any?
      next if GardeningPicture.where(picture_id: picture.id).any?
      next if BlogPicture.where(picture_id: picture.id).any?
      picture.destroy
    end
  end

  def create_recipe_picture(uploaded_picture, recipe_id)
    picture = create_picture(uploaded_picture)
    if picture.save
      RecipePicture.create(picture_id: picture.id, recipe_id: recipe_id)
    end
  end

  def create_gardening_picture(uploaded_picture, gardening_id)
    picture = create_picture(uploaded_picture)
    if picture.save
      GardeningPicture.create(picture_id: picture.id, gardening_id: gardening_id)
    end
  end

  def create_blog_picture(uploaded_picture, blog_id)
    picture = create_picture(uploaded_picture)
    if picture.save
      BlogPicture.create(picture_id: picture.id, blog_id: blog_id)
    end
  end

  def create_picture(uploaded_picture)
    picture = Picture.new do |pic|
      orig = Magick::Image::from_blob(uploaded_picture.read).first

      if orig.columns > 200
        small = orig.copy
        small.change_geometry!('200x') { |cols, rows, img| img.resize!(cols, rows) }
        pic.small = small.to_blob
      else
        pic.small = orig.to_blob
      end

      thumbnail = orig.copy
      thumbnail.change_geometry!('100x100') { |cols, rows, img| img.resize!(cols, rows) }
      pic.thumbnail = thumbnail.to_blob
      
      if orig.columns > 1600
        orig.change_geometry!('1600x') { |cols, rows, img| img.resize!(cols, rows) }
      end
      pic.content = orig.to_blob

      pic.name = uploaded_picture.original_filename
      pic.mime_type = uploaded_picture.content_type
    end
    return picture
  end
end
