module FeedData
  class Driver < ApplicationInteraction
    interface :action
    interface :mapper, methods: %i[run]
    hash :params, strip: false
    boolean :async, default: true

    def execute
      payload.each do |data|
        if async
          action.perform_later(data: data, locale: params[:locale].to_s)
        else
          action.run!(data: data, locale: params[:locale].to_sym)
        end
      end
    end

  private

    def payload
      mapper.run!(params: params)
    end
  end
end
