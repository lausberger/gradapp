# frozen_string_literal: true

# Controller class for Student Checklist
class StudentChecklistsController < ApplicationController
  before_action :require_login

  def index
    @student = Account.find_by(id: @current_user)
    Rails.logger.debug @student.id
    @student_checklist = StudentChecklist.find_by(account_id: @student.id)
    return redirect_to home_path unless !@student_checklist.nil?
  end

  def update
    items = %w[citizenship_checkbox research_area_checkbox degree_objective_checkbox ug_inst_checkbox ug_gpa_checkbox
               ug_degree_checkbox ug_major_checkbox ug_transcript_checkbox grad_inst_checkbox grad_gpa_checkbox
               grad_degree_checkbox grad_major_checkbox grad_transcript_checkbox letter_recommendations_checkbox
               language_scores_checkbox resume_checkbox sop_checkbox]
    student = Account.find_by(id: @current_user)
    student_checklist = StudentChecklist.find(student.id)
    items.each do |item|
      if params.include? item
        student_checklist.update("#{item.partition('_checkbox')[0]}": true)
      else
        student_checklist.update("#{item.partition('_checkbox')[0]}": false)
      end
    end
    student_checklist.save!

    redirect_to student_checklist_path
  end
end
