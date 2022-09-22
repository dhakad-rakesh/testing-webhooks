class PopupSerializer < ActiveModel::Serializer
  attributes :id, :title, :screen, :name, :platform, :repeat_type, :repeat_duration, :link, :redirection, :start_date, :end_date, :status, :structure
end
