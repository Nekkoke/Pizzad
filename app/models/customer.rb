class Customer < ApplicationRecord
    has_secure_password

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
