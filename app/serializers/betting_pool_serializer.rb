class BettingPoolSerializer < BaseSerializer
  attributes :id, :name, :status, :entry_amount, :winnings_distribution_method, :participants_count
  has_many :matches
  has_many :participants, if: -> { should_render_association }

  def participants_count
    object.participants.size
  end

  def should_render_association
    @instance_options[:show_children]
  end
end
