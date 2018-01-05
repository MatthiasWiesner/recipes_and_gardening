class AddPublishedFlagToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :published, :boolean
  end
end
