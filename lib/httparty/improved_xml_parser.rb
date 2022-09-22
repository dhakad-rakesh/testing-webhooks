# frozen_string_literal: true

module HTTParty
  class ImprovedXmlParser < HTTParty::Parser
    def xml
      MultiXml.parse(body, typecast_xml_value: false)
    end
  end
end
