class Employee < ApplicationRecord
    has_secure_password

    attr_accessor :current_password_admin
    validates :password, presence: { if: :current_password_admin }

end
