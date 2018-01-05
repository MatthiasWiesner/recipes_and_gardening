class CreateRecipePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_pictures do |t|
      t.references :recipe
      t.references :picture

      t.timestamps
    end
  end
end
