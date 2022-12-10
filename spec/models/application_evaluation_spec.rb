# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe ApplicationEvaluation do
  # TODO: implement
  describe 'creating an evaluation' do
    before(:each) do
      @sample_evaluation = {
        score: 4,
        comment: "Excellent application, give this man all the University's funding!"
      }
    end
    describe 'with valid application parameters' do
      it 'should successfully create an application' do
        test = ApplicationEvaluation.create(@sample_evaluation)
        expect(test.valid?).to be_truthy
      end
    end
    describe 'with an invalid score' do
      it 'should result in an invalid evaluation object' do
        @sample_evaluation[:score] = 6
        test = ApplicationEvaluation.create(@sample_evaluation)
        expect(test.valid?).to be_falsey

        @sample_evaluation[:score] = 'test'
        test = ApplicationEvaluation.create(@sample_evaluation)
        expect(test.valid?).to be_falsey
      end
    end
    describe 'with an invalid comment' do
      it 'should result in an invalid evaluation object' do
        @sample_evaluation[:comment] = 6
        test = ApplicationEvaluation.create(@sample_evaluation)
        expect(test.valid?).to be_falsey
      end
    end
  end
end
