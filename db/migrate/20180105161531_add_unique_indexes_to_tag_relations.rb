class AddUniqueIndexesToTagRelations < ActiveRecord::Migration[5.1]
  def change
    add_index :recipe_tags, [:recipe_id, :tag_id], :unique => true
    add_index :gardening_tags, [:gardening_id, :tag_id], :unique => true
  end
end
