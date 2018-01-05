class CreateRecipeTags < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_tags do |t|
      t.references :recipe
      t.references :tag

      t.timestamps
    end
  end
end
