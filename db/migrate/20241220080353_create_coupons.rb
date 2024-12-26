class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name,null:false#クーポン名
      t.integer :discount,null:false#割引率
      t.timestamps
    end
  end
end
