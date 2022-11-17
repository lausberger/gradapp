class FacultysController < ApplicationController

  def index
    @faculties_and_topic_area = []
    faculties = Faculty.all
    faculties.each do |faculty|
      @faculties_and_topic_area << {
        :first_name => faculty.account[:first_name],
        :last_name => faculty.account[:last_name],
        :topic_area => faculty[:topic_area]
      }
    end
  end

  def search
    @topic_area = params[:search_topic_area]
    if @topic_area == '' or @topic_area == nil
      flash[:warning] = "Invalid topic area specified!"
      return redirect_to facultys_path
    end
    @faculties = Faculty.where(:topic_area => @topic_area)
    if @faculties.length == 0
      flash[:warning] = "No Faculty members with the topic area specified!"
      redirect_to facultys_path
    end
  end
end
