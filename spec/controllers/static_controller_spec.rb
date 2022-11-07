require 'spec_helper'
require 'rails_helper'

describe StaticController do
  describe 'Home Page' do
    it 'should render the home template' do
      get :gradapp_path
      expect(response).to render_template('home_page')
    end
  end
end
