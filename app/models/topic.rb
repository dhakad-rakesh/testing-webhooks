class Topic < ApplicationRecord
  has_and_belongs_to_many :users

  def self.find_or_create_topic(topic_name)
    topic = Topic.find_or_initialize_by(name: topic_name)
    topic.enabled = false if topic.new_record?
    topic.save && topic
  end
end
