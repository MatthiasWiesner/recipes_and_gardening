class AddMoreSizesToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :small, :binary
    add_column :pictures, :thumbnail, :binary
  end
end
