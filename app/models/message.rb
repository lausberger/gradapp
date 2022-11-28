# frozen_string_literal: true

class Message < ActiveRecord::Base
  belongs_to :to, class_name: 'Account'
  belongs_to :from, class_name: 'Account'
  validates :to_id, :from_id, :to_email, :from_email, :body, presence: true
end
