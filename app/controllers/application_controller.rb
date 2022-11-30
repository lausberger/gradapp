# frozen_string_literal: true

require 'google/cloud/storage'

# handles application-level functionality
class ApplicationController < ActionController::Base
  # rubocop:disable Lint/Void
  @student_document_bucket
  # rubocop:enable Lint/Void
  @gcloud_active = false

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_gcloud
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= Account.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    (flash[:warning] = 'You must be logged in to perform that action') and (redirect_to login_path) unless logged_in?
  end

  private

  def load_gcloud
    return if Rails.env.test? || !ENV.key?('GOOGLE_STORAGE_CREDENTIALS')

    storage = Google::Cloud::Storage.new(
      project_id: ENV['GOOGLE_STORAGE_PROJECT'],
      credentials: ENV['GOOGLE_STORAGE_CREDENTIALS']
    )
    @student_document_bucket = storage.bucket ENV['GOOGLE_STORAGE_BUCKET']
    @gcloud_active = true
  end
end
