class CreateRequires < ActiveRecord::Migration[7.0]
  def change
    create_table :requires do |t|
      t.references :stock,null:false#外部キー
      t.references :product,null:false#外部キー
      t.integer :number,null:false#数値
      t.timestamps
    end
  end
end
