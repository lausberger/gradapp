# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5'
    module ActionController
      class TestResponse < ActionDispatch::TestResponse
        def recycle!
          # HACK: to avoid MonitorMixin double-initialize error:
          @mon_mutex_owner_object_id = nil
          @mon_mutex = nil
          initialize
        end
      end
    end
  else
    puts 'Monkeypatch for ActionController::TestResponse no longer needed'
  end
end

describe Account do
  describe 'parameter validation' do
    before(:each) do
      @account_params = {
        first_name: 'Lucas',
        last_name: 'Ausberger',
        email: 'lausberger@uiowa.edu',
        password_digest: 'password',
        account_type: 'Student'
      }
    end
    it 'should fail if invalid email' do
      @account_params[:email] = 'lausberger'
      expect(Account.new(@account_params).valid?).to eq false
    end
    it 'should fail without a password' do
      @account_params[:password_digest] = nil
      expect(Account.new(@account_params).valid?).to eq false
    end
    it 'should fail without a first name' do
      @account_params[:first_name] = nil
      expect(Account.new(@account_params).valid?).to eq false
    end
    it 'should fail without a last name' do
      @account_params[:last_name] = nil
      expect(Account.new(@account_params).valid?).to eq false
    end
    it 'should fail without a valid type' do
      @account_params[:account_type] = nil
      expect(Account.new(@account_params).valid?).to eq false
    end
  end

  describe 'adding an account to database' do
    context 'Student' do
      before(:all) do
        account_params = {
          first_name: 'Lucas',
          last_name: 'Ausberger',
          email: 'lausberger@uiowa.edu',
          password_digest: 'password',
          account_type: 'Student'
        }
        @account = Account.create(account_params)
      end
      it 'should appear in set of Students' do
        expect(Student.where(email: @account.email)).to exist
      end
      it 'should appear in set of Accounts' do
        expect(Account.where(email: @account.email)).to exist
      end
      it 'should NOT appear in set of Faculty' do
        pending "Needs to be updated to work with new account and faculty table"
        expect(Faculty.where(email: @account.email)).not_to exist
      end
    end
  end
end
