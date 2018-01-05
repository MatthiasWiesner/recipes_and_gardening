class AddPublishedToGardening < ActiveRecord::Migration[5.1]
  def change
    add_column :gardenings, :published, :boolean
  end
end
