describe Account do
    before(:each) do
        @account_params = {
            :first_name => "Lucas", 
            :last_name => "Ausberger", 
            :email => "lausberger@uiowa.edu", 
            :password_digest => "password", 
            :type => "Student"
        }
    end

    describe 'parameter validation' do
        it 'should fail if invalid email' do
            @account_params[:email] = "lausberger"
            expect(Account).to receive(:new).with(@account_params)
                .and_raise(ValidationError)
            account = Account.new(@account_params)
        end
        it 'should fail without a password' do
            @account_params[:password_digest] = nil
            expect(Account).to receive(:new).with(@account_params)
                .and_raise(ArgumentError)
            account = Account.new(@account_params)
        end
        it 'should fail without a first name' do
            @account_params[:first_name] = nil
            expect(Account).to receive(:new).with(@account_params)
                .and_raise(ArgumentError)
            account = Account.new(@account_params)
        end
        it 'should fail without a last name' do
            @account_params[:last_name] = nil
            expect(Account).to receive(:new).with(@account_params)
                .and_raise(ArgumentError)
            account = Account.new(@account_params)
        end
        it 'should fail without a valid type' do
            @account_params[:type] = "Loser"
            expect(Account).to receive(:new).with(@account_params)
                .and_raise(ArgumentError)
            account = Account.new(@account_params)
        end
    end

    describe 'adding an account to database' do
        context 'Student' do
            before(:each) do
                @account = Account.new(@account_params)
            end
            it 'should invoke the save method' do
                expect(Account).to receive(:save)
            end
            it 'should appear in set of Students' do
                expect(Student.all.include? @account).to eq true
            end
            it 'should appear in set of Accounts' do 
                expect(Account.all.include? @account).to eq true
            end
            it 'should NOT appear in set of Faculty' do
                expect(Faculty.all.include? @account).to eq false
            end
        end
    end
end