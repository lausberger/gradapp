# frozen_string_literal: true

# Account Model class
class Account < ActiveRecord::Base
  # represents password in a secure manner, maps to password_digest
  has_secure_password

  has_many :to_messages, class_name: 'Message', foreign_key: 'to_id'
  has_many :from_messages, class_name: 'Message', foreign_key: 'from_id'

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true
  validates :type, presence: true
end
