class Api::FriendsController < Api::BaseController
  def index
    friends = current_user.friends.paginate(page: params[:page], per_page: params[:per_page])
    render_collection(friends)
  end

  def destroy
    friend = User.find_by(id: params[:id].to_i)
    return render_not_found_response(I18n.t('friend.not_found')) unless friend && current_user.friends.include?(friend)
    return render_success_response(I18n.t('friend.remove.success')) if current_user.remove_friend(friend)
    render_error_response(I18n.t('friend.remove.fail'))
  end
end
