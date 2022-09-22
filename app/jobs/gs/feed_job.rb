module GS
  class FeedJob < ApplicationJob
    queue_as :amqp_processes

    def perform(stream)
      xml_path = fetch_xml_path stream
      return if xml_path.blank?
      # AuditLogJob is respoinsible for logging amqp data, enqueue OddsSummaryJob and enqueue fixture_change
      #Rails.cache.write(:last_amqp_data_at, Time.now.utc)
      #AuditLogJob.perform_later(routing_key, timestamp, xml)
      LiveMatchMarketsOddsChangeJob.perform_later(xml_path)
      #return(BetStopJob.perform_later(*args)) if routing_key.include?('bet_stop')
      #Bet resolution logic from data push by Goal serve
      #return(FeedResultJob.perform_later(xml)) #check required here according to goal serve API response
    end

    private

    def fetch_xml_path(stream)
      begin
        zip_file = File.open("/tmp/live_data/#{Time.zone.now.to_i.to_s}.gz", "w+")
        stream.rewind
        zip_file.write(stream.read.force_encoding("UTF-8"))
        zip_file.close
        system("gunzip -k #{zip_file.path} -f")
        xml_path = zip_file.path.gsub(".gz", "")
        FileUtils.rm_f(zip_file.path) if File.exist?(zip_file.path)
        return xml_path
      rescue ::StandardError => exception
        nil
      end
    end
  end
end
