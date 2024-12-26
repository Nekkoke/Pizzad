class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false # 外部キー
      t.integer :price, null: false       # 価格
      t.string :store, null: false        # 店舗
      t.string :state, null: false        # 状態
      t.string :address, null: false      # 住所
      t.timestamps
    end
  end
end
