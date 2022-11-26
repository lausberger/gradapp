#TODO: Once login is implemented changes may need to be made to some tests to make them pass
describe MessagesController do
  describe 'Viewing messages' do
    it 'Should render the messages page' do
      fake_results = double('account')
      allow(Account).to receive(:find_by).with(email: 'jdoe@gmail.com').and_return fake_results
      allow(fake_results).to receive(:id).and_return '1'
      fake_results2 = double('messages')
      allow(Message).to receive(:where).with(to_id: '1').and_return fake_results2
      get :index
      expect(response).to render_template('index')
    end
  end
  describe 'Sending a message' do
    context 'with a valid request' do
      it 'should redirect to my messages' do
        fake_results = double('account')
        allow(Account).to receive(:find_by).with(email: 'jdoe@gmail.com').and_return fake_results
        allow(fake_results).to receive(:id).and_return '1'
        allow(fake_results).to receive(:email).and_return 'jdoe@gmail.com'
        post :sendMessage, :to => 'jdoe@gmail.com', :subject => 'Hello', :body => 'Hi. Hey.'
        expect(response).to redirect_to('/messages')
      end
      it 'should say the message was sent' do
        fake_results = double('account1')
        allow(Account).to receive(:find_by).with(email: 'jdoe@gmail.com').and_return fake_results
        allow(fake_results).to receive(:id).and_return '1'
        allow(fake_results).to receive(:email).and_return 'jdoe@gmail.com'
        post :sendMessage, :to => 'jdoe@gmail.com', :subject => 'Hello', :body => 'Hi. Hey.'
        expect(flash[:notice]).to match(/Message Sent/)
      end
      it 'should return http response created' do
        fake_results = double('account1')
        allow(Account).to receive(:find_by).with(email: 'jdoe@gmail.com').and_return fake_results
        allow(fake_results).to receive(:id).and_return '1'
        allow(fake_results).to receive(:email).and_return 'jdoe@gmail.com'
        post :sendMessage, :to => 'jdoe@gmail.com', :subject => 'Hello', :body => 'Hi. Hey.'
        expect(response).to have_http_status(:found)
      end
    end
    context 'with an invalid email' do
      it 'should redirect to new messages page' do
        post :sendMessage, :to => '', :subject => 'Hello', :body => 'Hi. Hey.'
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say an incorrect email was used' do
        post :sendMessage, :to => '', :subject => 'Hello', :body => 'Hi. Hey.'
        expect(flash[:warning]).to match(/Please enter a correct email address/)
      end
      it 'should return http response created' do
        post :sendMessage, :to => '', :subject => 'Hello', :body => 'Hi. Hey.'
        expect(response).to have_http_status(:found)
      end
    end
    context 'with an invalid body' do
      it 'should redirect to new messages page' do
        fake_results = double('account1')
        allow(Account).to receive(:find_by).with(email: 'jdoe@gmail.com').and_return fake_results
        allow(fake_results).to receive(:id).and_return '1'
        allow(fake_results).to receive(:email).and_return 'jdoe@gmail.com'
        post :sendMessage, :to => 'jdoe@gmail.com', :subject => 'Hello', :body => ''
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say the body is empty' do
        fake_results = double('account1')
        allow(Account).to receive(:find_by).with(email: 'jdoe@gmail.com').and_return fake_results
        allow(fake_results).to receive(:id).and_return '1'
        allow(fake_results).to receive(:email).and_return 'jdoe@gmail.com'
        post :sendMessage, :to => 'jdoe@gmail.com', :subject => 'Hello', :body => ''
        expect(flash[:warning]).to match(/Please enter a body for your message/)
      end
      it 'should return http response created' do
        fake_results = double('account1')
        allow(Account).to receive(:find_by).with(email: 'jdoe@gmail.com').and_return fake_results
        allow(fake_results).to receive(:id).and_return '1'
        allow(fake_results).to receive(:email).and_return 'jdoe@gmail.com'
        post :sendMessage, :to => 'jdoe@gmail.com', :subject => 'Hello', :body => ''
        expect(response).to have_http_status(:found)
      end
    end
  end
end
