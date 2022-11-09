class DiscussionsController < ApplicationController

  def show
    discussion_id = params[:id]
    @root_discussion = Discussion.get_root_post(discussion_id)
    @discussions_with_replies = Discussion.get_post_replies(@root_discussion[:id])
  end

  def index
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
