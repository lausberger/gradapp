# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe GraduateApplication do
  before(:each) do
    @sample_student = {
      first_name: 'Brandon',
      last_name: 'Egger',
      email: 'beggr@uiowa.edu',
      phone: '3196408865',
      dob: Date.new,
      status: 'submitted'
    }
  end
  describe 'creating a graduate application' do
    context 'with required valid fields entered' do
      it 'should create a new graduate application' do
        expect { GraduateApplication.create(@sample_student) }.not_to raise_exception
        puts GraduateApplication.create(@sample_student).errors.messages
        expect(GraduateApplication.create(@sample_student).valid?).to be_truthy
      end
    end
    context 'with incorrect phone number' do
      it 'should be invalid' do
        @sample_student[:phone] = '319542'
        expect(GraduateApplication.create(@sample_student).valid?).to be_falsey
        @sample_student[:phone] = 319_395_747_899
        expect(GraduateApplication.create(@sample_student).valid?).to be_falsey
      end
    end
    context 'with incorrect status' do
      it 'should be invalid' do
        @sample_student[:status] = 'not-done'
        expect(GraduateApplication.create(@sample_student).valid?).to be_falsey
      end
    end
    context 'with invalid email' do
      it 'should be invalid' do
        @sample_student[:email] = 'brandon'
        expect(GraduateApplication.create(@sample_student).valid?).to be_falsey
      end
    end
  end
  describe 'formatting a students full name' do
    before(:each) { @student = GraduateApplication.create(@sample_student) }
    it 'should return the students full name' do
      expect(@student.full_name).to match(/Brandon Egger/)
    end
  end
end
