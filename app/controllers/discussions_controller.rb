# frozen_string_literal: true

# Main discussions functionality controller
class DiscussionsController < ApplicationController
  # before_action :require_login

  before_action :require_login, only: %i[new create create_reply edit update destroy]

  before_action :optional_login, only: %i[show index]

  def optional_login
    @current_user = current_user
  end

  def show
    discussion_id = params[:id]
    @root_discussion = Discussion.root_post(discussion_id)
    @discussions_with_replies = Discussion.post_replies(@root_discussion[:id])
  end

  def index
    @discussions = Discussion.root_posts
  end

  def new; end

  def create
    acc = Account.find_by(id: @current_user)
    discussion = params[:discussion]
    root_id = -1
    if discussion.key? :root_discussion_id
      root_id = discussion[:root_discussion_id]
    end
    Discussion.create!(title: discussion[:title], body: discussion[:body], account_id: acc[:id],
                       root_discussion_id: root_id)
    redirect_to discussions_path
  end

  def create_reply
    acc = Account.find_by(id: @current_user)
    discussion = params[:discussion]
    root_discussion_id = discussion[:root_discussion_id]
    body = discussion[:body]
    account_id = acc[:id]
    Discussion.create!(title: '', body: body, account_id: account_id, root_discussion_id: root_discussion_id)
    redirect_to discussion_path(root_discussion_id)
  end

  def edit
    id = params[:id]
    @discussion = Discussion.find(id)
  end

  def update
    id = params[:id]
    new_title = params[:discussion][:title]
    new_body = params[:discussion][:body]
    discussion = Discussion.find(id)
    discussion.update(title: new_title)
    discussion.update(body: new_body)
    if discussion[:root_discussion_id].to_i != -1
      return redirect_to discussion_path(discussion[:root_discussion_id])
    end

    redirect_to discussions_path
  end

  def destroy
    id = params[:id]
    discussion = Discussion.find(id)
    discussion.destroy
    if discussion[:root_discussion_id].to_i != -1
      return redirect_to discussion_path(discussion[:root_discussion_id])
    end

    redirect_to discussions_path
  end
end
