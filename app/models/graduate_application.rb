# frozen_string_literal: true

# Graduate Application model class
class GraduateApplication < ActiveRecord::Base
  def self.all_status
    %w[in-progress submitted denied accepted]
  end

  validates :first_name, :last_name, presence: true, format: { with: /\A\S+\z/, message: 'No white spaces in names' }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, format: { with: /\A\d{9,11}\z/, message: 'only digits' }
  validates :dob, presence: true
  validates :gpa_scale, :gpa_value, presence: true
  validates :status, inclusion: { in: all_status }
  validate :gpa_value_lte_must_be_scale

  def gpa_ratio
    gpa_value / gpa_scale
  end

  def gpa_default_scale
    gpa_ratio * 4
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def gpa_value_lte_must_be_scale
    is_invalid = gpa_scale.is_a?(Numeric) && gpa_value.is_a?(Numeric) && (gpa_value > gpa_scale)
    errors.add(:gpa_value, "GPA can't exceed the scale value.") if is_invalid
  end
end
