class Message < ActiveRecord::Base
  belongs_to :to, class_name: 'Account'
  belongs_to :from, class_name: 'Account'
  validates :to, :from, :to_name, :from_name, :body, presence: true
end
