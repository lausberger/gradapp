# frozen_string_literal: true

# Graduate Application model class
class GraduateApplication < ActiveRecord::Base
  def self.all_status
    %w[in-progress submitted denied accepted withdrawn]
  end

  belongs_to :account
  has_many :documents, dependent: :destroy, inverse_of: :graduate_application
  has_many :educations, dependent: :destroy, inverse_of: :graduate_application
  has_many :application_evaluations, dependent: :destroy
  accepts_nested_attributes_for :educations, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :documents, allow_destroy: true, reject_if: :all_blank

  validates :first_name, :last_name, presence: true, format: { with: /\A\S+\z/, message: 'No white spaces in names' }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, format: { with: /\A\d{9,11}\z/, message: 'only digits' }
  validates :dob, presence: true
  validates :status, inclusion: { in: all_status }

  def average_gpa_ratio
    sum = 0
    count = 0
    educations.all.find_each do |education|
      sum += education.gpa_ratio
      count += 1
    end
    return 0 if count.zero?

    sum / count
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def withdraw
    self.status = 'withdrawn'
  end
end
