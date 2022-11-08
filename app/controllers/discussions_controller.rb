class DiscussionsController < ApplicationController

  def show
    # TODO
    discussion_id = params[:id]
    puts discussion_id
    @root_discussion = {:id => 0, :title => "Title 1", :body => "Body 1", :author => "Author 1", :root_discussion_id => 0}
    @discussions_with_replies = [{:id => 0, :title => "Title 1", :body => "Body 1", :author => "Author 1", :root_discussion_id => 0}, {:id => 1,:title => "Title 2", :body => "Body 2", :author => "Author 2", :root_discussion_id => 0}, {:id => 3,:title => "Title 3", :body => "Body 3", :author => "Author 3", :root_discussion_id => 0}]
  end

  def index
    # TODO
    #@discussions = [{:id => 0, :title => "Title 1", :body => "Body 1", :author => "Author 1", :root_discussion_id => 0}, {:id => 1,:title => "Title 2", :body => "Body 2", :author => "Author 2", :root_discussion_id => 0}, {:id => 3,:title => "Title 3", :body => "Body 3", :author => "Author 3", :root_discussion_id => 0}]
    @discussions = Discussion.get_root_posts
  end

  def new
    # TODO
    puts "New: #{params}"
  end

  def create
    # TODO
    puts "Create: #{params}"
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  def destroy
    # TODO
  end

end
