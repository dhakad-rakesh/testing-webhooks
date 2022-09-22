class Users::InvitationsController < Devise::InvitationsController
  def create
    flash[:notice] =
      if User.find_by(invite_params).blank?
        user = User.invite!(invite_params, current_user) do |u|
          u.skip_invitation = true
        end
        accept_user_invitation_url(invitation_token: user.raw_invitation_token)
        user.invitation_sent_at = Time.zone.now
        user.deliver_invitation
        t('.success')
      else
        t('.exists')
      end
    redirect_to new_user_invitation_path
  end

  private

  def invite_resource
    super do |u|
      u.skip_invitation = false
    end
  end

  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    resource
  end

  def after_accept_path_for(resource)
    user = current_user.invited_by
    user.update(invitations_count: user.invitations_count + 1)
    current_user.friendships.create(friend: user)
    super
  end

  def invite_params
    params.require(:user).permit(:email)
  end
end
