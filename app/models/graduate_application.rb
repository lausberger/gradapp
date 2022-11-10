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

  def gpa_ratio
    self.gpa_value / self.gpa_scale;
  end

  def full_name
    self.first_name + " " + self.last_name
  end

end
