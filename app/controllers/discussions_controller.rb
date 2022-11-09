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
    discussion = params[:discussion]
    Discussion.create!(:title => discussion[:title], :body => discussion[:body], :author => discussion[:author], :root_discussion_id => -1)
  end

  def create
    # TODO
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
