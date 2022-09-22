module Qtech
  class CreateGameJob < ApplicationJob
    queue_as :low

    def perform(data)
      return if data.nil?
      Qtech::CreateGame.run!(data: data)
    end
  end
end
