class ApplicationJob < ActiveJob::Base
  # TODO: Need To move this
  def fetch_data_from_xml(xml)
    Hash.from_xml(xml).with_indifferent_access
  end
end
