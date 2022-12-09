# frozen_string_literal: true

# Controller class for Find Faculty
class FacultiesController < ApplicationController
  def index
    @faculties_and_topic_area = []
    faculties = Faculty.all
    faculties.each do |faculty|
      @faculties_and_topic_area << {
        first_name: faculty.account[:first_name],
        last_name: faculty.account[:last_name],
        topic_area: faculty[:topic_area]
      }
    end
  end

  def search
    @topic_area = params[:search_topic_area]
    if (@topic_area == '') || @topic_area.nil?
      flash[:warning] = 'Invalid topic area specified!'
      return redirect_to faculties_path
    end
    @faculties = Faculty.where(topic_area: @topic_area)
    (flash[:notice] = "No faculty members with topic area matching \"#{@topic_area}\" were found") and (redirect_to faculties_path) if @faculties.length.zero?
  end
end
