module LS
  class ScheduleMatch < ApplicationInteraction
    object :sport
    string :kind, default: nil

    def execute
      data = client.fixtures
      return if data.nil? || data[:Body].nil?

      create_matches(data)
      create_zip_file("ls_#{sport.name}_fixtures.json", data)
    rescue ::StandardError => e
      custom_error_logger(e)
      NotificationMailer.schedule_matches_job("#{e.class} :: #{e.message}", e.backtrace.split(',')).deliver_later
    end

    private

    def create_matches(data)
      data[:Body].each do |fixture_data|
        fixture_id = fixture_data[:FixtureId]
        fixture = fixture_data[:Fixture]
        next if ![1].include?(fixture[:Status]) && kind == nil # Create and update not_started matches only

        next if [2, 8, 9].include?(fixture[:Status]) && kind == 'monitor' # skip about_to_start, coverage and in_progress matches

        match = Match.find_by uid: fixture_id
        # next if match.present? 
        LS::CreateMatchJob.perform_later(fixture_id, fixture)
      end
    end

    def client
      @client ||= Lsports::Client.new(sport: sport)
    end

    def create_zip_file(file_name, data)
      file_name = "/tmp/#{file_name}"
      FileUtils.rm_f("#{file_name}.gz") if File.exist?("#{file_name}.gz")
      file = File.open(file_name, 'w+')
      file.rewind
      file.write(data)
      file.close
      system("gzip #{file_name}")
      FileUtils.rm_f(file.path) if File.exist?(file.path)
    rescue ::StandardError => e
      nil
    end

    def custom_error_logger(exception)
      Honeybadger.notify(
        "[Process ScheduleMatch] : [#{exception.class}] : [#{exception.cause}]"
      )
    end
  end
end
