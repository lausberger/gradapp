class GraduateApplication < ActiveRecord::Base
  def self.all_status
    {
      :in_progress => 0,
      :submitted => 1,
      :denied => 3,
      :accepted => 4,
    }
  end
end
