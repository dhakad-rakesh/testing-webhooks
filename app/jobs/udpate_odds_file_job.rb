class UpdateOddsFileJob < ApplicationJob
  queue_as :low

  def perform
    #return unless Rails.env.staging?
    client = GoalServe::Client.new
    active_sports = ['soccer', 'basket', 'tennis']
    active_sports.each do |sport|
      file_name = "#{sport}.json"
      data = client.schedules("/#{file_name}")
      create_zip_file(file_name, data)
    end
  end

  private

  def create_zip_file(file_name, data)
    begin
      file_name = "/tmp/#{file_name}"
      zip_file = File.open(file_name, "w+")
      zip_file.rewind
      zip_file.write(data)
      zip_file.close
      system("gzip #{file_name}")
      FileUtils.rm_f(zip_file.path) if File.exist?(zip_file.path)
    rescue ::StandardError => exception
      nil
    end
  end
end
