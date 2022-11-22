class StudentChecklistsController < ApplicationController

  def show
    student_id = params[:id]
    @student = Account.find(student_id)
    @student_checklist = StudentChecklist.find_by(:student_id => student_id)
  end

  def update
    items = %w[citizenship_checkbox research_area_checkbox degree_objective_checkbox ug_inst_checkbox ug_gpa_checkbox
               ug_degree_checkbox ug_major_checkbox ug_transcript_checkbox grad_inst_checkbox grad_gpa_checkbox
               grad_degree_checkbox grad_major_checkbox grad_transcript_checkbox letter_recommendations_checkbox
               language_scores_checkbox resume_checkbox sop_checkbox]
    student_id = params[:id]
    student_checklist = StudentChecklist.find(student_id)
    items.each do |item|
      if params.include? item
        student_checklist.update("#{item.partition("_checkbox")[0]}": true)
      else
        student_checklist.update("#{item.partition("_checkbox")[0]}": false)
      end
    end
    student_checklist.save!

    redirect_to student_checklist_path
  end
end
