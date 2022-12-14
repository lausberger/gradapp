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
  validates :currently_attending, inclusion: { in: [true, false] }
  validates :start_date, :end_date, presence: true
  validate :gpa_value_lte_must_be_scale, :start_date_before_end_date

  def gpa_ratio
    gpa_value / gpa_scale
  end

  def gpa_default_scale
    gpa_ratio * 4
  end

  private

  def start_date_before_end_date
    is_invalid = !start_date.is_a?(Date) || !end_date.is_a?(Date) || start_date >= end_date
    errors.add(:start_date, "Start date can't be greater than or equal to the end date.") if is_invalid
  end

  def gpa_value_lte_must_be_scale
    is_invalid = !gpa_scale.is_a?(Numeric) || !gpa_value.is_a?(Numeric) || (gpa_value > gpa_scale)
    errors.add(:gpa_value, "GPA can't exceed the scale value.") if is_invalid
  end
end
