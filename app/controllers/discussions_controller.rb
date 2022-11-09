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

  end

  def create
    discussion = params[:discussion]
    root_id = -1
    if discussion.has_key? :root_discussion_id
      root_id = discussion[:root_discussion_id]
    end
    Discussion.create!(:title => discussion[:title], :body => discussion[:body], :author => discussion[:author], :root_discussion_id => root_id)
    redirect_to discussions_path
  end

  def create_reply
    puts "Create reply: #{params}"
  end

  def edit
    id = params[:id]
    @discussion = Discussion.find(id)
  end

  def update
    puts "Params #{params}"
    id = params[:id]
    new_title = params[:discussion][:title]
    new_body = params[:discussion][:body]
    discussion = Discussion.find(id)
    discussion[:title] = new_title
    discussion[:body] = new_body
    Discussion.update(discussion)
    if discussion[:root_discussion_id] != -1
      return redirect_to discussion_path(discussion[:root_discussion_id])
    end
    redirect_to discussions_path
  end

  def destroy
    id = params[:id]
    discussion = Discussion.find(id)
    discussion.destroy
    if discussion[:root_discussion_id] != -1
      return redirect_to discussion_path(discussion[:root_discussion_id])
    end
    redirect_to discussions_path
  end

end
