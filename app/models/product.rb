class Product < ApplicationRecord
    has_many_attached :images
    has_many :order_items

    #検索メソッド
    class << self
        def search(query, prod)
          rel = order("id")
          
      # 名前で絞り込み
      rel = rel.where("name LIKE ?", "%#{query}%") if query.present?

      # kinds、kid、rec で絞り込み
      case prod
      when "pizza", "side", "drink"
        rel = rel.where(kinds: prod)
      when "kid"
        rel = rel.where(kids: true) 
      when "recommend"
        rel = rel.where(recommend: true) 
      when "指定なし"

      end
  
      rel
    end
  end
end    

