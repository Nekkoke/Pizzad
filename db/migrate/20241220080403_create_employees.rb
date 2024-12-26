class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.boolean :admin,null:false#管理者フラグ
      t.string :name,null:false#名前
      t.string :fullname,null:false#本名
      t.string :password_digest,null:false
      t.timestamps
    end
  end
end
