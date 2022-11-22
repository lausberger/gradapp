class MessagesController < ApplicationController
  def index
    # render index page when going to /messages
    id = Account.find_by(email: "jdoe@gmail.com")
    @messages = Message.where(to_id: id)
  end
  def new
  end
  def sendMessage
    id = Account.find_by(email: "jdoe@gmail.com")
    redirect_to "/messages"
  end
end
