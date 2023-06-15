# frozen_string_literal: true

module Users
  module Otp
    class SessionsController < DeviseController
      include OtpSessionExpirable
      before_action :expire_otp_session!
      prepend_before_action :require_no_authentication, only: [:new, :create]

      def new
        unless User.exists?(session[:otp_user_id])
          session[:otp_user_id] = nil
          redirect_to(new_user_session_path)
        end
      end

      def create
        resource = warden.authenticate!(
          :otp_attempt_authenticatable,
          {
            scope: resource_name,
            recall: "#{controller_path}#new",
          },
        )

        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        respond_with(resource, location: after_sign_in_path_for(resource))
      end
    end
  end
end
