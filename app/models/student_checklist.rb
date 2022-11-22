# frozen_string_literal: true

# Model class for Student Checklist
class StudentChecklist < ActiveRecord::Base
  belongs_to :student

  validates :student_id, presence: true, uniqueness: true
end
