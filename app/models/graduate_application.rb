# frozen_string_literal: true

# Graduate Application model class
class GraduateApplication < ActiveRecord::Base
  def self.all_status
    %w[in-progress submitted denied accepted]
  end

  has_many :educations, dependent: :destroy

  validates :first_name, :last_name, presence: true, format: { with: /\A\S+\z/, message: 'No white spaces in names' }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, format: { with: /\A\d{9,11}\z/, message: 'only digits' }
  validates :dob, timeliness: { type: :date }
  validates :status, inclusion: { in: all_status }

  def full_name
    "#{first_name} #{last_name}"
  end

end
