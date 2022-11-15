class Faculty < Account

  validates :topic_area, presence: true

  def self.get_all
    Faculty.get_all
  end

  def self.get_by_topic_area(selected_topic_area)
    Faculty.where(topic_area: selected_topic_area)
  end

end
