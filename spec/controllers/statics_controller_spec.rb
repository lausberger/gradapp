# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe StaticsController do
  describe 'When accessing the home page' do
    context 'while not logged in ' do
      before(:all) do
        delete :destroy
      end
      it 'should render the public home page' do
        get 'home'
        expect(response).to render_template('public_home')
      end
    end
  end
  describe 'FAQ Page' do
    it 'should render the statics template for faq page' do
      get 'faq'
      expect(response).to render_template('faq')
    end
  end
  if RUBY_VERSION >= '2.6.0'
    if Rails.version < '5'
      module ActionController
        class TestResponse < ActionDispatch::TestResponse
          def recycle!
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
end
