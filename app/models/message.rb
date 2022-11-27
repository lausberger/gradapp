# frozen_string_literal: true

class Message < ActiveRecord::Base
  belongs_to :to, class_name: 'Account', inverse_of: :account
  belongs_to :from, class_name: 'Account', inverse_of: :account
  validates :to_id, :from_id, :to_email, :from_email, :body, presence: true
end
