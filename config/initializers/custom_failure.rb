class CustomFailure < Devise::FailureApp
  def redirect_url
    scope.to_sym == :admin_user ? new_admin_user_session_path : root_url
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end