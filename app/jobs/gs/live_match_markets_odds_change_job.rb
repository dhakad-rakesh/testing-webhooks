module GS
  class LiveMatchMarketsOddsChangeJob < ApplicationJob
    queue_as :amqp_processes

    def perform(xml_path = "")
      begin
        json_data = fetch_json_data(xml_path)
        last_ts = Rails.cache.fetch(:last_gs_data_ts)
        return if last_ts == json_data[:updated_ts]
        last_ts = Rails.cache.write(:last_gs_data_ts, json_data[:updated_ts])
        json_data = GoalServe::Format::LiveOdds.new(json_data).call
        json_data.each do |data|
          GS::LiveMatchMarketOddsChangeJob.perform_later(data)
        end
      rescue Errno::ENOENT
        return nil
        #raise_honeybadger_errors(exception)
        #FileUtils.rm_f(xml_path) if File.exist?(xml_path)
      end
    end

    private

    def raise_honeybadger_errors(exception)
      Honeybadger.notify(
        "[LiveMatchMarketsOddsChangeJob Error] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

    def fetch_json_data(xml_path)
      null = ""
      file = File.open(xml_path, "r")
      file.rewind
      xml = eval file.read
      FileUtils.rm_f(xml_path) if File.exist?(xml_path)
      xml
    end
  end
end
