# frozen_string_literal: true

# Graduate application controller class for handling associated views for grad applications
class GraduateApplicationsController < ApplicationController
  before_action :parse_educations_form_data, :upload_documents, only: [:create]
  before_action :require_login

  def index
    if @current_user.account_type.eql? 'Faculty'
      @graduate_applications = GraduateApplication.all
      return
    end

    @graduate_applications = GraduateApplication.where(['account_id = ?', @current_user.id])
  end

  def show
    id = params[:id]
    @graduate_application = GraduateApplication.find(id)

    return if @current_user.account_type.eql? 'Student'

    @my_evaluation = @graduate_application.application_evaluations.find_by(account_id: @current_user.id)
    @my_evaluation = ApplicationEvaluation.new if @my_evaluation.nil?
    @other_evaluations = @graduate_application.application_evaluations
    @evaluations_list = evaluations_list
  end

  def new
    @graduate_application = GraduateApplication.new
  end

  def withdraw
    unless params.key? :id
      flash[:notice] = 'Application withdraw failed'
      redirect_to home_path
      return
    end

    current_application = @current_user.graduate_applications.find_by(id: params[:id])
    if current_application.nil?
      flash[:notice] = 'Application withdraw failed'
      redirect_to home_path
      return
    end

    Rails.logger.debug current_application
    current_application.withdraw
    flash[:notice] = 'Application has been withdrawn'
    redirect_to graduate_applications_path
  end

  def create
    @graduate_application = @current_user.graduate_applications.create(@graduate_application_params)
    flash[:notice] = 'Graduate application was successfully submitted.' if @graduate_application.valid?
    flash[:notice] = 'Application submission failed, please retry.' unless @graduate_application.valid?
    @graduate_application.status = 'denied' unless @graduate_application.valid?

    if @graduate_application.valid?
      redirect_to graduate_applications_path
    else
      render 'new'
    end
  end

  private

  def parse_educations_form_data
    @graduate_application_params = graduate_application_params.to_hash
    @graduate_application_params[:status] = 'submitted'

    return unless @graduate_application_params.key?('educations_attributes')

    @graduate_application_params['educations_attributes'].each do |key, _value|
      is_attending = @graduate_application_params['educations_attributes'][key]['currently_attending'] == '1'
      @graduate_application_params['educations_attributes'][key]['currently_attending'] = is_attending
    end
  end

  def upload_documents
    return unless @graduate_application_params.key?('documents_attributes')

    test_mode = Rails.env.test?

    if !@gcloud_active && !test_mode
      flash[:notice] = 'Unable to upload documents at this time - Google Cloud Error'
      @graduate_application_params.delete('documents_attributes')
      @graduate_application = GraduateApplication.create(@graduate_application_params)
      render 'new'
    end

    @graduate_application_params['documents_attributes'].each do |key, value|
      temp_file_path = value['file'].path
      original_file_name = value['file'].original_filename

      bucket_path = "applications/documents/#{value['file'].hash}/#{original_file_name}"
      save_file(temp_file_path, bucket_path)

      @graduate_application_params['documents_attributes'][key].delete('file')
      @graduate_application_params['documents_attributes'][key]['name'] = original_file_name
      @graduate_application_params['documents_attributes'][key]['file_ref'] = bucket_path
    end
  end

  def graduate_application_params
    education_attr = %i[id school_name degree major gpa_value gpa_scale currently_attending start_date end_date _destroy]
    document_attr = %i[name description file _destroy]
    params.require(:graduate_application).permit(:first_name, :last_name, :email, :phone, :dob, educations_attributes: education_attr,
                                                                                                documents_attributes: document_attr)
  end

  def save_file(temp_file_path, bucket_file_path)
    @student_document_bucket.create_file temp_file_path, bucket_file_path unless Rails.env.test?
  end

  def evaluations_list
    # TODO: Make this only show accounts that don't belong to the current_user
    result_set = []
    @graduate_application.application_evaluations.each do |eval|
      account = Account.find(eval.account_id)
      new_eval = {
        name: "#{account.first_name} #{account.last_name}",
        score: eval.score,
        comment: eval.comment
      }
      result_set.append(new_eval)
    end

    result_set
  end
end
