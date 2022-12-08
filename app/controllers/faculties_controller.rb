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
        research_area: ResearchArea.find(faculty[:research_area_id]).title
      }
    end
  end

  def search
    @research_area = params[:search_research_area]
    if (@research_area == '') || @research_area.nil?
      flash[:warning] = 'Invalid research area specified!'
      return redirect_to faculties_path
    end
    @research_area_id = ResearchArea.where(title: @research_area)
    @faculties = Faculty.where(research_area_id: @research_area_id)
    if @faculties.length.zero? then
      flash[:message] = 'No faculty found for given research area'
      redirect_to faculties_path
    end
  end
end
