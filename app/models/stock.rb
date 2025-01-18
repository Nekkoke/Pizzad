class Stock < ApplicationRecord
  has_many :toppings, dependent: :destroy
  has_many :products, through: :toppings


  validates :name, presence: true,
                   length: { maximum: 19, allow_blank: true },
                   uniqueness: { case_sensitive: false }
  validates :number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :assort, presence: true, inclusion: { in: ['vegetable', 'meat', 'seafood', 'others'] }

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
