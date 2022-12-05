# frozen_string_literal: true

describe MessagesController do
  describe 'Viewing messages' do
    it 'Should render the messages page' do
      # Stubbing the logged in account
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
        # Stubbing the logged in account
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
      end
      it 'should redirect to my messages' do
        expect { post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.' }.to change { Message.count }.by(1)
        expect(response).to redirect_to('/messages')
      end
      it 'should say the message was sent' do
        expect { post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.' }.to change { Message.count }.by(1)
        expect(flash[:notice]).to match(/Message Sent/)
      end
      it 'should return http response created' do
        expect { post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.' }.to change { Message.count }.by(1)
        expect(response).to have_http_status(:found)
      end
    end
    context 'with an invalid email' do
      before(:each) do
        allow(controller).to receive(:logged_in?).and_return(true)
      end
      it 'should redirect to new messages page' do
        expect { post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.' }.to change { Message.count }.by(0)
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say an incorrect email was used' do
        expect { post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.' }.to change { Message.count }.by(0)
        expect(flash[:warning]).to match(/Please enter a correct email address/)
      end
      it 'should return http response created' do
        expect { post :send_message, to: '', subject: 'Hello', body: 'Hi. Hey.' }.to change { Message.count }.by(0)
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
        expect { post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: '' }.to change { Message.count }.by(0)
        expect(response).to redirect_to('/messages/new')
      end
      it 'should say the body is empty' do
        expect { post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: '' }.to change { Message.count }.by(0)
        expect(flash[:warning]).to match(/Please enter a body for your message/)
      end
      it 'should return http response created' do
        expect { post :send_message, to: 'jdoe@gmail.com', subject: 'Hello', body: '' }.to change { Message.count }.by(0)
        expect(response).to have_http_status(:found)
      end
    end
  end
  describe 'Replying to a message' do
    context 'Viewing a reply page' do
      it 'Should render the reply page' do
        # Stubbing the logged in account
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
        controller.instance_variable_set(:@current_user, @acc)
        # Need to stub the message that's being replied to
        dummy_message = double('message')
        allow(Message).to receive(:find_by).and_return(dummy_message)
        allow(dummy_message).to receive(:from_id).and_return(@acc.id)
        allow(dummy_message).to receive(:from_email).and_return('jdoe@gmail.com')
        allow(dummy_message).to receive(:to_id).and_return(@acc.id)
        get :show
        expect(response).to render_template('show')
      end
      context 'Viewing a reply page when you arent the logged in user' do
        it 'Should redirect to the messages page' do
          # Stubbing the logged in account
          @acc = create(:account)
          allow(controller).to receive(:logged_in?).and_return(true)
          allow(Account).to receive(:find_by).and_return @acc
          controller.instance_variable_set(:@current_user, @acc)
          # Need to stub the message that's being replied to
          dummy_message = double('message')
          allow(Message).to receive(:find_by).and_return(dummy_message)
          allow(dummy_message).to receive(:from_id).and_return(@acc.id)
          allow(dummy_message).to receive(:from_email).and_return('jdoe@gmail.com')
          # NOTE: This was changed so that the logged in user and
          # the person who received the message are different.
          allow(dummy_message).to receive(:to_id).and_return('zz')
          get :show
          expect(response).to redirect_to('/messages')
          expect(flash[:warning]).to match(/You cannot view this message/)
        end
      end
      context 'Viewing a reply page for a message that does not exist' do
        it 'Should redirect to the messages page' do
          # Stubbing the logged in account
          @acc = create(:account)
          allow(controller).to receive(:logged_in?).and_return(true)
          allow(Account).to receive(:find_by).and_return @acc
          controller.instance_variable_set(:@current_user, @acc)
          get :show
          expect(response).to redirect_to('/messages')
        end
      end
    end
    context 'with a valid reply' do
      before(:each) do
        # Stubbing the logged in account
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
        controller.instance_variable_set(:@current_user, @acc)
        # Need to stub the message that's being replied to
        dummy_message = double('message')
        allow(Message).to receive(:find_by).and_return(dummy_message)
        allow(dummy_message).to receive(:from_id).and_return(@acc.id)
        allow(dummy_message).to receive(:from_email).and_return('jdoe@gmail.com')
        allow(dummy_message).to receive(:to_id).and_return(@acc.id)
      end
      it 'should redirect to my messages' do
        expect { post :reply_message, body: 'Hello' }.to change { Message.count }.by(1)
        expect(response).to redirect_to('/messages')
      end
      it 'should say the reply was sent' do
        expect { post :reply_message, body: 'Hello' }.to change { Message.count }.by(1)
        expect(flash[:notice]).to match(/Reply Sent/)
      end
      it 'should return http response created' do
        expect { post :reply_message, body: 'Hello' }.to change { Message.count }.by(1)
        expect(response).to have_http_status(:found)
      end
    end
    context 'when logged in as someone different' do
      before(:each) do
        # Stubbing the logged in account
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
        controller.instance_variable_set(:@current_user, @acc)
        # Need to stub the message that's being replied to
        dummy_message = double('message')
        allow(Message).to receive(:find_by).and_return(dummy_message)
        allow(dummy_message).to receive(:from_id).and_return(@acc.id)
        allow(dummy_message).to receive(:from_email).and_return('jdoe@gmail.com')
        # NOTE: This was changed so that the logged in user and
        # the person who received the message are different.
        allow(dummy_message).to receive(:to_id).and_return('zz')
      end
      it 'should redirect to my messages and not add a reply' do
        expect { post :reply_message, body: 'Hello' }.to change { Message.count }.by(0)
        expect(response).to redirect_to('/messages')
      end
      it 'should flash a warning and not add a reply' do
        expect { post :reply_message, body: 'Hello' }.to change { Message.count }.by(0)
        expect(flash[:warning]).to match(/You cannot reply to a message you were not sent/)
      end
      it 'should return http response created and not add a reply' do
        expect { post :reply_message, body: 'Hello' }.to change { Message.count }.by(0)
        expect(response).to have_http_status(:found)
      end
    end
    context 'viewing messages page after messages and replies sent' do
      before(:each) do
        @acc = create(:account)
        allow(controller).to receive(:logged_in?).and_return(true)
        allow(Account).to receive(:find_by).and_return @acc
        controller.instance_variable_set(:@current_user, @acc)
        mes = Message.create!(to_id: @acc.id, from_id: @acc.id, to_email: @acc.email, from_email: @acc.email, subject: 'hi', body: 'test')
        Message.create!(to_id: @acc.id, from_id: @acc.id, to_email: @acc.email, from_email: @acc.email, subject: 'hi2', body: 'test2', messages_id: mes.id)
      end
      it 'should render the index template correctly' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end
end
