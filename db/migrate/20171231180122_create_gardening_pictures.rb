class CreateGardeningPictures < ActiveRecord::Migration[5.1]
  def change
    create_table :gardening_pictures do |t|
      t.references :gardening
      t.references :picture

      t.timestamps
    end
  end
end
