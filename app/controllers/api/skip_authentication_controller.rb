class Api::SkipAuthenticationController < Api::BaseController
  skip_before_action :user_authorize!
end
