class FacultysController < ApplicationController

  def index
    @faculties_and_topic_area = []
    faculties = Account.where(:type => "Faculty")
    faculties.each do |faculty|
      puts Faculty.find(1)[:account_id]
      @faculties_and_topic_area << {
        :first_name => faculty[:first_name],
        :last_name => faculty[:last_name],
        :topic_area => Faculty.find(faculty[:id])[:account_id]
      }
    end
    puts @faculties_and_topic_area
  end

  def search
    @topic_area = params[:search_topic_area]
    @faculties = Faculty.where(:topic_area => @topic_area)
  end

end
