class CreateToppings < ActiveRecord::Migration[7.0]
  def change
    create_table :toppings do |t|
      t.references :stock,null:false#外部キー
      t.string :name,null:false#名
      t.integer :price,null:false#値段
      t.integer :number,null:false#消費数
      t.timestamps
    end
  end
end
