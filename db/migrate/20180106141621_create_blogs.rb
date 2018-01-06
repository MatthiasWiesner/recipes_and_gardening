class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :name
      t.text :description
      t.text :content
      t.boolean :published

      t.timestamps
    end
  end
end
