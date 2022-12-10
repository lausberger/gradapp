# frozen_string_literal: true

# Controller for the private messages page and sending a message
class MessagesController < ApplicationController
  before_action :require_login
  def index
    # render index page when going to /messages
    acc = Account.find_by(id: @current_user)
    all_messages = Message.where(to_id: acc.id)
    @messages = []
    all_messages.each do |message|
      if message.messages_id.nil?
        messagehash = { message: message, reply: [] }
      else
        replyid = message.messages_id
        parent = Message.find(replyid)
        messagehash = { message: message, reply: [parent] }
      end
      @messages.append(messagehash)
      @messages.reverse!()
    end
  end

  def show
    @message = Message.find_by(id: params[:format])
    redirect_to messages_path and return if @message.nil?
    return if @current_user.id == @message.to_id

    flash[:warning] = 'You cannot view this message'
    redirect_to messages_path
  end

  def send_message
    acc = Account.find_by(id: @current_user)
    to = params[:to]
    to_acc = Account.find_by(email: to)
    if to_acc.nil?
      flash[:warning] = 'Please enter a correct email address'
      redirect_to messages_new_path and return
    end
    to_id = to_acc.id
    subject = params[:subject]
    body = params[:body]
    if body.blank?
      flash[:warning] = 'Please enter a body for your message'
      redirect_to messages_new_path and return
    end
    Message.create!(to_id: to_id, from_id: acc.id, to_email: to, from_email: acc.email, subject: subject, body: body)
    flash[:notice] = 'Message Sent'
    redirect_to messages_path
  end

  def reply_message
    acc = Account.find_by(id: @current_user)
    reply_id = params[:reply]
    reply = Message.find_by(id: reply_id)
    to_id = reply.from_id
    to_email = reply.from_email
    body = params[:body]
    if @current_user.id != reply.to_id
      flash[:warning] = 'You cannot reply to a message you were not sent'
      redirect_to messages_path and return
    end
    Message.create!(to_id: to_id, from_id: acc.id, to_email: to_email, from_email: acc.email, body: body, messages_id: reply_id)
    flash[:notice] = 'Reply Sent'
    redirect_to messages_path
  end
end
