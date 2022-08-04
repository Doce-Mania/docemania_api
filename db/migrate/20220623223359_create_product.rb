class CreateProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :image
      t.string :name
      t.string :price
      t.string :quantity
      t.string :description

      t.timestamps
    end
  end
end
