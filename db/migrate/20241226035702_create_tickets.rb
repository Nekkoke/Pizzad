class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :coupon,null:false#外部キー
      t.references :customer,null:false#外部キー
      t.timestamps
    end
  end
end
