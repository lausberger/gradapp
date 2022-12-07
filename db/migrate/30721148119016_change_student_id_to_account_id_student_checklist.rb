# frozen_string_literal: true

# Migration to allow student_checklists to reference account table
class ChangeStudentIdToAccountIdStudentChecklist < ActiveRecord::Migration
  def change
    add_reference :student_checklists, :account, foreign_key: { to_table: :account }, index: true
    remove_column :student_checklists, :student_id
  end
end
