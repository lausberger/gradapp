# frozen_string_literal: true

# Controller for the private messages page and sending a message
class MessagesController < ApplicationController
  before_action :require_login
  def index
    # render index page when going to /messages
    acc = Account.find_by(id: @current_user)
    allMessages = Message.where(to_id: acc.id)
    @messages = []
    allMessages.each do |message|
      if message.messages_id.nil?
        messagehash = {:message => message, :reply => []}
        @messages.append(messagehash)
      else
        replyid = message.messages_id
        parent = Message.find(replyid)
        messagehash = {:message => message, :reply => [parent]}
        @messages.append(messagehash)
      end
    end
  end

  def show
    @message = Message.find_by(id: params[:format])
    if @current_user.id != @message.to_id
      flash[:warning] = 'You cannot view this message'
      redirect_to '/messages'
    end
  end

  def send_message
    acc = Account.find_by(id: @current_user)
    to = params[:to]
    to_acc = Account.find_by(email: to)
    if to_acc.nil?
      flash[:warning] = 'Please enter a correct email address'
      redirect_to '/messages/new' and return
    end
    to_id = to_acc.id
    subject = params[:subject]
    body = params[:body]
    if body.length.zero?
      flash[:warning] = 'Please enter a body for your message'
      redirect_to '/messages/new' and return
    end
    Message.create!(to_id: to_id, from_id: acc.id, to_email: to, from_email: acc.email, subject: subject, body: body)
    flash[:notice] = 'Message Sent'
    redirect_to '/messages'
  end

  def reply_message
    acc = Account.find_by(id: @current_user)
    reply_id = params[:reply]
    reply = Message.find_by(id: reply_id)
    to_id = reply.from_id
    to_email = reply.from_email
    body = params[:body]
    Message.create!(to_id: to_id, from_id: acc.id, to_email: to_email, from_email: acc.email, body: body, messages_id: reply_id)
    redirect_to '/messages'
  end
end
