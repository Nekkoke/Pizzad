class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :product,null:false#外部キー
      t.references :order,null:false#外部キー
      t.integer :number,null:false#数値
      t.string :size,null:false#ピザの大きさ
      t.timestamps
    end
  end
end
