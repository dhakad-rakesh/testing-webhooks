class Favourites < ApplicationInteraction
  string :favouriteable_type
  integer :favouriteable_id
  object :user
  boolean :is_default, default: false

  set_callback :execute, :before, -> { resource }

  def execute
    unless @resource
      errors.add(:base, I18n.t('not_found', name: favouriteable_type))
      return
    end
    favourite = @resource.favourites.find_or_initialize_by(user_id: user.id)
    favourite.is_default = default_favourite
    favourite.save && favourite
  end

  private

  def default_favourite
    return false unless is_default
    ActiveRecord::Type::Boolean.new.cast is_default
  end

  def resource
    return if favouriteable_id.blank?
    @favouriteable_type = favouriteable_type
    @resource = sport || team || tournament
  end

  def sport
    return unless favouriteable_type == 'Sport'
    Sport.find_by(id: favouriteable_id)
  end

  def team
    return unless favouriteable_type == 'Team'
    Team.find_by(id: favouriteable_id)
  end

  def tournament
    return unless favouriteable_type == 'Tournament'
    Tournament.find_by(id: favouriteable_id)
  end
end
