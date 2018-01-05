class AddAttributesToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :ingredients, :text
    add_column :recipes, :preparation, :text
    remove_column :recipes, :content
  end
end
