# frozen_string_literal: true

# TODO: Once login is implemented changes may need to be made to some tests to make them pass
describe MessagesController do
  describe 'Viewing messages' do
    it 'Should render the messages page' do
      acc = create(:account)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      get :index
      expect(response).to render_template('index')
    end
  end
  describe 'Sending a message' do
    context 'with a valid request' do
      before(:each) do
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
      end
      it 'should redirect to my messages' do
        expect {post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.'}.to change {Message.count}.by(1)
        expect(response).to redirect_to('/messages')
      end
      it 'should say the message was sent' do
        expect {post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.'}.to change {Message.count}.by(1)
        expect(flash[:notice]).to match(/Message Sent/)
      end
      it 'should return http response created' do
        expect {post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.'}.to change {Message.count}.by(1)
        expect(response).to have_http_status(:found)
      end
    end
    context 'with an invalid email' do
      before(:each) do
        allow(controller).to receive(:logged_in?).and_return(true)
      end
      it 'should redirect to new messages page' do
        expect {post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.'}.to change {Message.count}.by(0)
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say an incorrect email was used' do
        expect {post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.'}.to change {Message.count}.by(0)
        expect(flash[:warning]).to match(/Please enter a correct email address/)
      end
      it 'should return http response created' do
        expect {post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.'}.to change {Message.count}.by(0)
        expect(response).to have_http_status(:found)
      end
    end
    context 'with an invalid body' do
      before(:each) do
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
      end
      it 'should redirect to new messages page' do
        expect {post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: ''}.to change {Message.count}.by(0)
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say the body is empty' do
        expect {post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: ''}.to change {Message.count}.by(0)
        expect(flash[:warning]).to match(/Please enter a body for your message/)
      end
      it 'should return http response created' do
        expect {post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: ''}.to change {Message.count}.by(0)
        expect(response).to have_http_status(:found)
      end
    end
  end
  describe 'Replying to a message' do
    context 'with a valid reply' do
      before(:each) do
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
        controller.instance_variable_set(:@current_user, @acc)
        #Need to stub the message that's being replied to
        dummyMessage = double("message")
        allow(Message).to receive(:find_by).and_return(dummyMessage)
        allow(dummyMessage).to receive(:from_id).and_return(@acc.id)
        allow(dummyMessage).to receive(:from_email).and_return("jdoe@gmail.com")
        allow(dummyMessage).to receive(:to_id).and_return(@acc.id)
      end
      it 'should redirect to my messages' do
        expect {post :reply_message, body: 'Hello'}.to change {Message.count}.by(1)
        expect(response).to redirect_to('/messages')
      end
      it 'should say the reply was sent' do
        expect {post :reply_message, body: 'Hello'}.to change {Message.count}.by(1)
        expect(flash[:notice]).to match(/Reply Sent/)
      end
      it 'should return http response created' do
        expect {post :reply_message, body: 'Hello'}.to change {Message.count}.by(1)
        expect(response).to have_http_status(:found)
      end
    end
  end
end
