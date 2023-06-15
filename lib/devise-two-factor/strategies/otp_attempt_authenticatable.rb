# frozen_string_literal: true

module Devise
  module Strategies
    # imporved version of https://github.com/tinfoil/devise-two-factor/blob/main/lib/devise_two_factor/strategies/two_factor_authenticatable.rb
    class OtpAttemptAuthenticatable < Devise::Strategies::Base
      def authenticate!
        resource = mapping.to.find(session[:otp_user_id])

        if validate_otp(resource)
          session[:otp_user_id] = nil
          session[:otp_user_id_expires_at] = nil
          success!(resource)
        else
          fail!("Failed to authenticate your code")
        end
      end

      private

      def validate_otp(resource)
        return true unless resource.otp_required_for_login
        return if params[scope]["otp_attempt"].nil?

        resource.validate_and_consume_otp!(params[scope]["otp_attempt"])
      end
    end
  end
end

Warden::Strategies.add(:otp_attempt_authenticatable, Devise::Strategies::OtpAttemptAuthenticatable)
