class CreateGardeningTags < ActiveRecord::Migration[5.1]
  def change
    create_table :gardening_tags do |t|
      t.references :gardening
      t.references :tag

      t.timestamps
    end
  end
end
