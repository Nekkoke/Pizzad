class Employee < ApplicationRecord
    has_secure_password

    validates :name, presence: true,
      format: {
        with: /\A[A-Za-z][A-Za-z0-9]*\z/,
        allow_blank: true,
        message: :invalid_employee_name
      },
      length: { minimum: 2, maximum: 20, allow_blank: true },
      uniqueness: { case_sensitive: false }
    validates :fullname, presence: true, length: { maximum: 20 }
    attr_accessor :current_password_admin
    validates :password, presence: { if: :current_password_admin }, length: { maximum: 20 }
end
