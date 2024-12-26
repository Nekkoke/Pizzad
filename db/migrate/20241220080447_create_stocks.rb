class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :name, null: false #名前
      t.integer :number, null: false #数値
      t.string :assort #属性
      t.timestamps
    end
  end
end
