require 'spec_helper'
require 'rails_helper'

describe DiscussionsController do
  describe 'adding discussion post' do
    it 'should add selected root discussion to db and load index template' do
      post :post_details, {:title => 'Title', :body => 'Body', :author => 'Author', :root_discussion_id => 0}
      expect(response).to render_template('index')
    end
    it 'should add reply to selected discussion to db and load show template for root discussion' do
      post :post_details, {:title => 'Title', :body => 'Body', :author => 'Author', :root_discussion_id => 1}
      expect(response).to render_template('show')
    end
  end
  describe 'delete discussion post' do
    it 'should delete root discussion from db and load index template' do
      delete :id, 1
      expect(response).to render_template('index')
    end
    it 'should delete reply to selected discussion from db and load show template for root discussion' do
      delete :id, 2
      expect(response).to render_template('show')
    end
  end
end
