# frozen_string_literal: true

# Controller class for Find Faculty
class FacultiesController < ApplicationController
  def index
    @faculties_and_research_area = []
    faculties = Faculty.all
    faculties.each do |faculty|
      @faculties_and_research_area << {
        first_name: faculty.account[:first_name],
        last_name: faculty.account[:last_name],
        research_area: !ResearchArea.find_by(id: faculty[:research_area_id]).nil? ? ResearchArea.find(faculty[:research_area_id]).title : 'None'
      }
    end
  end

  def search
    @research_area = params[:search_research_area]
    if (@research_area == '') || @research_area.nil?
      flash[:warning] = 'Invalid research area specified!'
      return redirect_to faculties_path
    end
<<<<<<< HEAD
    @faculties = Faculty.where(topic_area: @topic_area)
    (flash[:notice] = "No faculty members with topic area matching \"#{@topic_area}\" were found") and (redirect_to faculties_path) if @faculties.length.zero?
=======
    @research_area_id = ResearchArea.where(title: @research_area)
    @faculties = Faculty.where(research_area_id: @research_area_id)
    return unless @faculties.length.zero?

    flash[:message] = 'No faculty found for given research area'
    redirect_to faculties_path
>>>>>>> 9cb808b2988638559a409f3e2a95d9ea86195867
  end
end
