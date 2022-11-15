class GraduateApplication < ActiveRecord::Base
  def self.all_status
    %w(in-progress submitted denied accepted)
  end

  validates :first_name, :last_name, presence: true, format: {with: /\A\S+\z/, message: "No white spaces in names"}
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, format: {with: /\A\d{9,11}\z/, message: "only digits"}
  validates :dob, presence: true
  validates :gpa_scale, :gpa_value, presence: true
  validates :status, inclusion: { in: self.all_status }
  validate :gpa_value_lte_must_be_scale

  def gpa_ratio
    self.gpa_value / self.gpa_scale;
  end

  def gpa_default_scale
    self.gpa_ratio * 4
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  private
  def gpa_value_lte_must_be_scale
    if self.gpa_scale.is_a? Numeric and self.gpa_value.is_a? Numeric
      errors.add(:gpa_value, "GPA can't exceed the scale value.") if self.gpa_value > self.gpa_scale
    end
  end

end
