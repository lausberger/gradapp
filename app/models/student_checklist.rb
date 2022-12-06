# frozen_string_literal: true

# Model class for Student Checklist
class StudentChecklist < ActiveRecord::Base
  belongs_to :account

  validates :account_id, presence: true, uniqueness: true
end
