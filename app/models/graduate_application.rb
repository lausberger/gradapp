class GraduateApplication < ActiveRecord::Base
  def self.all_status
    %w(in-progress submitted denied accepted)
  end

  validates :first_name, :last_name, presence: true, format: {with: /\A\S+\z/, message: "No white spaces in names"}
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, format: {with: /\A\d{9,11}\z/, message: "only digits"}
  validates :dob, presence: true
  #validates :gpa, presence: true
  validates :status, inclusion: { in: self.all_status }

  def gpa=(val)
    raise ArgumentError unless val.is_a? Hash
    raise ArgumentError unless val.has_key? :numerator and val.has_key? :denominator
    raise ArgumentError unless val[:numerator].is_a? Numeric and val[:denominator].is_a? Numeric

    @gpa = {
      :numerator => val[:numerator],
      :denominator => val[:denominator],
    }
  end

  def gpa_ratio
    @gpa[:numerator]/@gpa[:denominator];
  end

  def full_name
    @first_name + " " + @last_name
  end

end
