class Product < ApplicationRecord
    has_one_attached :profile_picture #画像用
    attribute :new_profile_picture
    has_many :order_items

    before_save do
      if new_profile_picture
        self.profile_picture = new_profile_picture
      end
    end

    #検索メソッド
    class << self
        def search(query, prod, genre)
          rel = order("id")
          
      # 名前で絞り込み
      rel = rel.where("name LIKE ?", "%#{query}%", "%#{query}%") if query.present?

      # kinds、kid、rec で絞り込み
      case prod
      when "pizza", "side", "drink"
        rel = rel.where(kinds: prod)
      when "指定なし"
        
      end

      case genre
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

