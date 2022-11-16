class FacultysController < ApplicationController

  def index
    @faculties = [{:first_name => 'Hello', :last_name => 'World', :topic_area => 'CSE'}]
  end

  def search
    @faculties = [{:first_name => 'Hello', :last_name => 'World', :topic_area => 'CSE'}]
  end

  def show
    @faculties = [{:first_name => 'Hello', :last_name => 'World', :topic_area => 'CSE'}]
  end

end
