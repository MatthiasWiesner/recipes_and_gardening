class CreateBlogPictures < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_pictures do |t|
      t.references :blog
      t.references :picture

      t.timestamps
    end
  end
end
