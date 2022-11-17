class Account < ActiveRecord::Base

    # represents password in a secure manner, maps to password_digest
    has_secure_password

    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password_digest, presence: true
    validates :account_type, presence: true
end
