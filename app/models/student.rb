# frozen_string_literal: true

class Student < ActiveRecord::Base
  belongs_to :account
end
