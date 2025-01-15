class Stock < ApplicationRecord

  validates :name, presence: true,
                   length: { maximum: 20, allow_blank: true },
                   uniqueness: { case_sensitive: false }
  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :assort, presence: true, inclusion: { in: ['vegerable', 'meat', 'seafood', 'others'] }

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
