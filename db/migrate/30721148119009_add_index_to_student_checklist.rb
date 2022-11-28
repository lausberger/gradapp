# frozen_string_literal: true

# Add Index to Student Checklist Migration
class AddIndexToStudentChecklist < ActiveRecord::Migration
  def change
    add_index :student_checklists, :student_id, unique: true
  end
end
