# ApplicationAgent
class ApplicationAgent < ApplicationInteraction
  include Sidekiq::Worker

  def perform(hash_as_args = {}, metadata = {}); end
end
