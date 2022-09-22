module Translations
  class UpdateSport < ApplicationInteraction
    hash :data, strip: false
    symbol :locale

    set_callback :execute, :before, :sport

    def execute
      return unless sport
      Mobility.with_locale(locale) do
        sport.update(name: data['name'])
      end
    end

  protected

    def sport
      @sport ||= ::Sport.find_by(uid: data['uid'])
    end
  end
end
