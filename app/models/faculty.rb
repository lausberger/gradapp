# frozen_string_literal: true

class Faculty < ActiveRecord::Base
  belongs_to :account

  validates :topic_area, presence: true, allow_blank: false

end
