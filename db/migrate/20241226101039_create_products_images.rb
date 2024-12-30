class CreateProductsImages < ActiveRecord::Migration[7.0]
  def change
    create_table :products_images do |t|
      t.references :product #外部キー
      t.string :alt_text, null: false, dafault:"" #代替テキスト
      t.integer :position #表示位置

      t.timestamps
    end
  end
end
