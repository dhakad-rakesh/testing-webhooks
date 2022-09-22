class Favourite < ApplicationRecord
  belongs_to :favouriteable, polymorphic: true
  belongs_to :user
  validates :user_id,
    uniqueness: { scope: %I[favouriteable_type favouriteable_id], message: 'Already marked this as favourite' }
  scope :defaults_with_user_id, ->(user_id) { default_favourites.where(user_id: user_id) }
  scope :default_favourites, -> { where(is_default: true) }

  scope :fetch_user_favourite_sport, -> { select(:id, :favouriteable_id).where(favouriteable_type: 'Sport') }
  scope :fetch_user_favourite_tournament, -> { select(:id, :favouriteable_id).where(favouriteable_type: 'Tournament') }

  after_save :add_user_favourites
  before_destroy :remove_user_favourites

  private

  def add_user_favourites
    user.update(
      "favourite_#{favouriteable_type.downcase}s" => user.send(
        "favourite_#{favouriteable_type.downcase}s"
      ).merge(id => favouriteable_id)
    )
  end

  def remove_user_favourites
    user.update(
      "favourite_#{favouriteable_type.downcase}s" => user.send(
        "favourite_#{favouriteable_type.downcase}s"
      ).except(id)
    )
  end
end
