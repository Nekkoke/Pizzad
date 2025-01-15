class Order < ApplicationRecord
    belongs_to :customer

    validates :address, presence: true, length: { maximum: 20 } #住所
    validates :store, presence: true

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

    class << self
    def status_text(status)
      status_options.to_h.invert[status]
    end

    def status_options
      STATUS_VALUES_JA.zip(STATUS_VALUES)
    end
  end
end
