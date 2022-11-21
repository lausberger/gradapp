class StudentChecklist < ActiveRecord::Base
  belongs_to :student

  validates :student_id, presence: true, uniqueness: true
end
