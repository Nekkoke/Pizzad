class CreateAccessories < ActiveRecord::Migration[7.0]
  def change
    create_table :accessories do |t|
      t.references :item,null:false#外部キー
      t.references :topping,null:false#外部キー
      t.timestamps
    end
  end
end
