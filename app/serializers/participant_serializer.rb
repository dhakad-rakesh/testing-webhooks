class ParticipantSerializer < BaseSerializer
  attributes :id, :username, :available_amount

  def username
    object.user.username
  end
end
