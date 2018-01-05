class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :name
      t.text :description
      t.string :mime_type
      t.binary :content

      t.timestamps
    end
  end
end
