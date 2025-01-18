class Coupon < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true,
      length: { maximum: 19, allow_blank: true }
  validates :discount, presence: true, 
    numericality: { 
        only_integer: true, 
        greater_than: 0, 
        less_than_or_equal_to: 100 
      }

    class << self
        def search(query)
          rel = order("id")
          if query.present?
            rel = rel.where("name LIKE ?",
              "%#{query}%")
          end
          rel
        end
      end
end
