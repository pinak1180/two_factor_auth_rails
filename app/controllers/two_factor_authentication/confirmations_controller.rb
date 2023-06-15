# frozen_string_literal: true

module TwoFactorAuthentication
  class ConfirmationsController < ApplicationController
    def new
      @qrcode = current_user.otp_qrcode
    end

    def show
      redirect_to(two_factor_authentication_path)
    end

    def create
      if current_user.validate_and_consume_otp!(params.dig(:otp_code))
        current_user.otp_required_for_login = true
        @recovery_codes = current_user.generate_otp_backup_codes!
        current_user.save!

        render("two_factor_authentication/confirmations/success")
      else
        flash.now[:alert] = "Failed to confirm the 2FA code"
        redirect_to(new_two_factor_authentication_confirmation_path)
      end
    end
  end
end
