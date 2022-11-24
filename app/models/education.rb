# frozen_string_literal: true

# Education details class belonging to a graduate application. Stores details regarding applicants
# past educations.
class Education < ActiveRecord::Base
  belongs_to :graduate_application
  def self.all_degrees
    %w[associate bachelor graduate doctorate]
  end

  validates :gpa_scale, :gpa_value, presence: true
  validates :major, :school_name, presence: true, format: { with: /\A[a-z\s]+\z/i, message: 'Only word characters and white spaces supported' }
  validates :degree, presence: true, inclusion: { in: all_degrees }
  validates :currently_attending, presence: true, inclusion: { in: %w[true false] }
  validates :start_date, :end_date, presence: true
  validate :gpa_value_lte_must_be_scale

  def gpa_ratio
    gpa_value / gpa_scale
  end

  def gpa_default_scale
    gpa_ratio * 4
  end

  private

  def gpa_value_lte_must_be_scale
    is_invalid = gpa_scale.is_a?(Numeric) && gpa_value.is_a?(Numeric) && (gpa_value > gpa_scale)
    errors.add(:gpa_value, "GPA can't exceed the scale value.") if is_invalid
  end
end
