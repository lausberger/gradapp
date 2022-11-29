# frozen_string_literal: true

# Account Model class
class Account < ActiveRecord::Base
  # represents password in a secure manner, maps to password_digest
  has_secure_password
  has_many :to_messages, class_name: 'Message', foreign_key: 'to_id', dependent: :destroy
  has_many :from_messages, class_name: 'Message', foreign_key: 'from_id', dependent: :destroy
  before_save :create_session_token
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :account_type, presence: true

  private

  def create_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end
end
