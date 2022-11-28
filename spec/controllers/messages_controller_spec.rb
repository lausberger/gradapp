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
        post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.'
        expect(response).to redirect_to('/messages')
      end
      it 'should say the message was sent' do
        post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.'
        expect(flash[:notice]).to match(/Message Sent/)
      end
      it 'should return http response created' do
        post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.'
        expect(response).to have_http_status(:found)
      end
    end
    context 'with an invalid email' do
      before(:each) do
        allow(controller).to receive(:logged_in?).and_return(true)
      end
      it 'should redirect to new messages page' do
        post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.'
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say an incorrect email was used' do
        post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.'
        expect(flash[:warning]).to match(/Please enter a correct email address/)
      end
      it 'should return http response created' do
        post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.'
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
        post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: ''
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say the body is empty' do
        post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: ''
        expect(flash[:warning]).to match(/Please enter a body for your message/)
      end
      it 'should return http response created' do
        post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: ''
        expect(response).to have_http_status(:found)
      end
    end
  end
end
