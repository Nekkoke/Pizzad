class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :kinds,null:false#種類
      t.string :name,null:false#名前
      t.integer :price,null:false#値段
      t.boolean :published,null:false#公開
      t.boolean :kids,null:false#子供向け
      t.boolean :recommend,null:false#おすすめ
      t.string :explanation#紹介文
      t.string :image_url #画像追加
      t.timestamps
    end
  end
end
