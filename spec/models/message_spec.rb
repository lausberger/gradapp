describe Message do
  before(:each) do
    acc = create(:account)
    @message= {
      to_id: acc.id,
      from_id: acc.id,
      to_email: acc.email,
      from_email: acc.email,
      subject: "Hi",
      body: "Hey. Hello."
    }
  end
  describe 'creating a message' do
    context 'with correct fields' do
      it 'should be valid' do
        expect { Message.create(@message) }.not_to raise_exception
        expect(Message.create(@message).valid?).to be_truthy
      end
    end
    context 'with incorrect id' do
      it 'should be invalid with incorrect to' do
        @message[:to_id] = ''
        expect(Message.create(@message).valid?).to be_falsey
      end
      it 'should be invalid with incorrect from' do
        @message[:from_id] = ''
        expect(Message.create(@message).valid?).to be_falsey
      end
    end
    context 'with a missing field' do
      it 'should be invalid missing to_id' do
        @message[:to_id] = nil
        expect(Message.create(@message).valid?).to be_falsey
      end
      it 'should be invalid missing from_id' do
        @message[:from_id] = nil
        expect(Message.create(@message).valid?).to be_falsey
      end
      it 'should be invalid missing to_email' do
        @message[:to_email] = nil
        expect(Message.create(@message).valid?).to be_falsey
      end
      it 'should be invalid missing from_email' do
        @message[:from_email] = nil
        expect(Message.create(@message).valid?).to be_falsey
      end
      it 'should be valid missing subject' do
        @message[:subject] = nil
        expect(Message.create(@message).valid?).to be_truthy
      end
      it 'should be invalid missing body' do
        @message[:body] = nil
        expect(Message.create(@message).valid?).to be_falsey
      end
    end
  end
end
