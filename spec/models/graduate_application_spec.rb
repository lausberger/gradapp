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
      status: 'submitted',
      gpa_value: 3.9,
      gpa_scale: 4.0
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
  describe 'formatting a students GPA' do
    before(:each) { @student = GraduateApplication.create(@sample_student) }
    it 'should return the students GPA ratio' do
      expect(@student.gpa_ratio).to eq 0.975
    end
  end
  describe 'withdrawing an application' do
    it 'should change the status of application to withdrawn' do
      @current_student = GraduateApplication.create(@sample_student)
      @current_student.withdraw
      expect(@current_student.status).to eq('withdrawn')
    end
  end
end
