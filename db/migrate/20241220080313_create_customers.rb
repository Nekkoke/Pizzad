class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name,null:false#ユーザーネーム
      t.string :fullname,null:false#本名
      t.string :address,null:false#住所
      t.string :mail#メール
      t.date :birthed_on#誕生日
      t.string :tel#電話番号
      t.string :password_digest,null:false#パスワード
      t.timestamps
    end
  end
end
