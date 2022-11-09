class Account < ActiveRecord::Base
    # represents password in a secure manner, maps to password_digest
    has_secure_password

    # email validity checking: must exist, be unique, and match regex
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
