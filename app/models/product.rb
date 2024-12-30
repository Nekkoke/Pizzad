class Product < ApplicationRecord
    has_many_attached :images
    has_many :order_items

    #検索メソッド
    class << self
        def search(query, prod)
          rel = order("id")
          
      # 名前で絞り込み
      rel = rel.where("name LIKE ?", "%#{query}%") if query.present?

      # kinds で絞り込み
      rel = rel.where(kinds: prod) if prod.present? && prod != "指定なし"

          rel
        end
      end
    end    

