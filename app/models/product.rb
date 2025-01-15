class Product < ApplicationRecord
    has_one_attached :profile_picture #画像用
    attribute :new_profile_picture
    has_many :order_items

    validates :name, presence: true,
    length: { maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false }
    validates :price, presence: true, numericality: 
    { 
     only_integer: true,
     greater_than: 0,
     less_than_or_equal_to: 9999  
    }
    validates :published, presence: true
    validates :kids, presence: true
    validates :recommend, presence: true
    validates :explanation, presence: true, length: { maximum: 200, allow_blank: true }

    validate if: :new_profile_picture do
      if new_profile_picture.respond_to?(:content_type)
        unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
          errors.add(:new_profile_picture, :invalid_image_type)
        end
      else
        errors.add(:new_profile_picture, :invalid)
      end
    end

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

