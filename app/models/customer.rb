class Customer < ApplicationRecord
    has_secure_password

    #バリデーション
    validates :name, presence: true,
      format: {
        with: /\A[A-Za-z][A-Za-z0-9]*\z/,
        allow_blank: true,
        message: :invalid_customer_name
      },
      length: { minimum: 2, maximum: 20, allow_blank: true },
      uniqueness: { case_sensitive: false }
    validates :fullname, presence: true, length: { maximum: 20 }
    #validates :mail, email: { allow_blank: true }

    attr_accessor :current_password
    validates :password, presence: { if: :current_password }

    validates :birthed_on, 
    comparison: { less_than_or_equal_to: Time.current.to_date }


    class << self
        def search(query)
          rel = order("id")
          if query.present?
            rel = rel.where("name LIKE ? OR fullname LIKE ?",
              "%#{query}%", "%#{query}%")
          end
          rel
        end
      end

      
end
