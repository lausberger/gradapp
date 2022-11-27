# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe Document do
  before(:each) do
    @sample_document = {
      name: 'file name here',
      description: 'This is a description of the attached file to be submitted',
      file_ref: 'test_ref'
    }
  end

  describe 'creating a document object' do
    context 'with required valid inputs' do
      it 'should be a valid model' do
        @doc = Document.create(@sample_document)
        expect(@doc.valid?).to be_truthy
      end
    end
    context 'with a name that it is too long' do
      it 'should be an invalid model' do
        @sample_document[:name] = 'a' * 51
        @doc = Document.create(@sample_document)
        expect(@doc.valid?).to be_falsey
      end
    end
    context 'with a missing required parameter' do
      it 'should be an invalid model' do
        @sample_document.delete(:name)
        @doc = Document.create(@sample_document)
        expect(@doc.valid?).to be_falsey
      end
    end
    context 'with the description parameter missing' do
      it 'should be a valid model' do
        @sample_document.delete(:description)
        @doc = Document.create(@sample_document)
        puts @doc.errors.full_messages
        expect(@doc.valid?).to be_truthy
      end
    end
  end
end
