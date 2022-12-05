# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

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

describe DiscussionsController do
  describe 'viewing applications' do
    before(:each) do
      account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'Password123',
        password_confirmation: 'Password123',
        account_type: 'Student'
      }
      Account.create! account
      discussion = {
        title: 'Test',
        body: 'Test',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: -1
      }
      Discussion.create! discussion
    end
    it 'should show all the main discussions' do
      get :index
      expect(response).to render_template('index')
    end
    it 'should show the template with discussion replies' do
      get :show, {id: Discussion.find_by(title: 'Test').id}
      expect(response).to render_template('show')
    end
  end
  describe 'creating discussions' do
    before(:each) do
      account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'Password123',
        password_confirmation: 'Password123',
        account_type: 'Student'
      }
      Account.create! account
      @discussion = {
        title: 'Test',
        body: 'Test',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: -1
      }
    end
    it 'should redirect to login page' do
      post :create, { discussion: @discussion }
      expect(response).to redirect_to login_path
    end
    it 'should show all the main discussions' do
      acc = create(:account)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      post :create, { discussion: @discussion }
      expect(response).to redirect_to discussions_path
    end
  end
  describe 'creating discussion replies' do
    before(:each) do
      account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'Password123',
        password_confirmation: 'Password123',
        account_type: 'Student'
      }
      Account.create! account
      discussion = {
        title: 'Test',
        body: 'Test',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: -1
      }
      Discussion.create! discussion
      @discussion_reply = {
        title: 'Hello',
        body: 'Hello World',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: Discussion.find_by(title: 'Test').id
      }
    end
    it 'should redirect to login page' do
      post :create_reply, { discussion: @discussion_reply }
      expect(response).to redirect_to login_path
    end
    it 'should show all the discussion replies' do
      acc = create(:account)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      post :create_reply, { discussion: @discussion_reply }
      expect(response).to redirect_to discussion_path(@discussion_reply[:root_discussion_id])
    end
  end
  describe 'editing discussions' do
    before(:each) do
      account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'Password123',
        password_confirmation: 'Password123',
        account_type: 'Student'
      }
      Account.create! account
      @discussion = {
        title: 'Test',
        body: 'Test',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: -1
      }
      Discussion.create! @discussion
    end
    it 'should redirect to login page' do
      put :update, { id: Discussion.find_by(title: 'Test').id, discussion: @discussion }
      expect(response).to redirect_to login_path
    end
    it 'should show all discussions' do
      acc = create(:account)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      put :update, { id: Discussion.find_by(title: 'Test').id, discussion: @discussion }
      expect(response).to redirect_to discussions_path
    end
  end
  describe 'editing discussions replies' do
    before(:each) do
      account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'Password123',
        password_confirmation: 'Password123',
        account_type: 'Student'
      }
      Account.create! account
      discussion = {
        title: 'Test',
        body: 'Test',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: -1
      }
      Discussion.create! discussion
      @discussion_reply = {
        title: 'Hello',
        body: 'Hello World',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: Discussion.find_by(title: 'Test').id
      }
      Discussion.create! @discussion_reply
    end
    it 'should redirect to login page' do
      put :update, { id: Discussion.find_by(title: 'Hello').id, discussion: @discussion_reply }
      expect(response).to redirect_to login_path
    end
    it 'should show all discussion replies' do
      acc = create(:account)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      put :update, { id: Discussion.find_by(title: 'Hello').id, discussion: @discussion_reply }
      expect(response).to redirect_to discussion_path(Discussion.find_by(title: 'Hello')[:root_discussion_id])
    end
  end
  describe 'deleting discussions' do
    before(:each) do
      account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'Password123',
        password_confirmation: 'Password123',
        account_type: 'Student'
      }
      Account.create! account
      @discussion = {
        title: 'Test',
        body: 'Test',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: -1
      }
      Discussion.create! @discussion
    end
    it 'should redirect to login page' do
      delete :destroy, { id: Discussion.find_by(title: 'Test').id }
      expect(response).to redirect_to login_path
    end
    it 'should show all discussions' do
      acc = create(:account)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      delete :destroy, { id: Discussion.find_by(title: 'Test').id }
      expect(response).to redirect_to discussions_path
    end
  end
  describe 'deleting discussion replies' do
    before(:each) do
      account = {
        first_name: 'Jack',
        last_name: 'Stockley',
        email: 'jack-stockley@uiowa.edu',
        password: 'Password123',
        password_confirmation: 'Password123',
        account_type: 'Student'
      }
      Account.create! account
      discussion = {
        title: 'Test',
        body: 'Test',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: -1
      }
      Discussion.create! discussion
      @discussion_reply = {
        title: 'Hello',
        body: 'Hello World',
        account_id: Account.find_by(first_name: 'Jack').id,
        root_discussion_id: Discussion.find_by(title: 'Test').id
      }
      Discussion.create! @discussion_reply
    end
    it 'should redirect to login page' do
      delete :destroy, { id: Discussion.find_by(title: 'Hello').id }
      expect(response).to redirect_to login_path
    end
    it ' should show all discussion replies' do
      acc = create(:account)
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(Account).to receive(:find_by).and_return acc
      root_discussion_id = Discussion.find_by(title: 'Hello')[:root_discussion_id]
      delete :destroy, { id: Discussion.find_by(title: 'Hello').id }
      expect(response).to redirect_to discussion_path(root_discussion_id)
    end
  end
end
