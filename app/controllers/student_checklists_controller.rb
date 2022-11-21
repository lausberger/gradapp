class StudentChecklistsController < ApplicationController

  def show
    student_id = params[:id]
    @student = Account.find(student_id)
    @student_checklist = StudentChecklist.find_by(:student_id => student_id)
  end

  def edit

  end
end
