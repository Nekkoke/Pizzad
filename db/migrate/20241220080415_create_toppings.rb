class CreateToppings < ActiveRecord::Migration[7.0]
  def change
    create_table :toppings do |t|
      t.references :product, null:false#外部キー
      t.references :stock, null:false#外部キー
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
