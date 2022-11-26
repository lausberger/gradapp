class MessagesController < ApplicationController
  def index
    # render index page when going to /messages
    acc = Account.find_by(email: "jdoe@gmail.com")
    @messages = Message.where(to_id: acc.id)
  end
  def new
  end
  def sendMessage
    acc = Account.find_by(email: "jdoe@gmail.com")
    to = params[:to]
    to_acc = Account.find_by(email: to)
    if to_acc.nil?
      flash[:warning] = "Please enter a correct email address"
      redirect_to "/messages/new" and return
    end
    to_id = to_acc.id
    subject = params[:subject]
    body = params[:body]
    if body.length == 0
      flash[:warning] = "Please enter a body for your message"
      redirect_to "/messages/new" and return
    end
    Message.create!(to_id: to_id, from_id: acc.id, to_email: to, from_email: acc.email, subject: subject, body: body)
    flash[:notice] = "Message Sent"
    redirect_to "/messages"
  end
end
