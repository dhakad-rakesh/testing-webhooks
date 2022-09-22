class Api::FriendRequestsController < Api::BaseController
  before_action :set_friend
  before_action :set_friend_request, only: %I[accept decline]

  # TODO : May need api for listing outgoing and incoming pending friend requests

  def create
    @friend_request = current_user.friend_requests.build(friend: @friend)
    return render_success_response(I18n.t('friend_request.sent.success')) if @friend_request.save
    render_error_response(I18n.t('friend_request.sent.fail', message: @friend_request.errors.full_messages.join('and')))
  end

  def accept
    @friend_request = @friend_request.accept
    return success_response(:accept) if @friend_request.errors.blank?
    error_response(:accept)
  end

  def decline
    return success_response(:decline) if @friend_request.destroy
    error_response(:decline)
  end

  private

  def success_response(context)
    render_success_response(I18n.t("friend_request.#{context}.success"))
  end

  def error_response(context)
    render_error_response(I18n.t("friend_request.#{context}.fail",
      message: @friend_request.errors.full_messages.join('and')))
  end

  def set_friend
    @friend = User.find_by(id: params[:friend_id].to_i)
    return render_not_found_response(I18n.t('friend.not_found')) unless @friend
  end

  def set_friend_request
    @friend_request = current_user.friend_requests.find_by(friend: @friend)
    render_not_found_response(I18n.t('friend_request.not_found')) unless @friend_request
  end
end
