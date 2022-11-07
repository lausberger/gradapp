require 'spec_helper'
require 'rails_helper'

describe StaticsController do
  describe 'Home Page' do
    it 'should render the statics template for home page' do
      get "/home"
      expect(response).to render_template('home')
    end
  end
end
