# frozen_string_literal: true

require "rails_helper"

RSpec.describe(TwoFactorAuthentication::ConfirmationsController, type: :request) do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET new_two_factor_authentication_confirmation_path" do
    it "renders the new confirmation page" do
      get new_two_factor_authentication_confirmation_path

      expect(response).to(have_http_status(:success))
    end
  end

  describe "POST two_factor_authentication_confirmations_path" do
    context "when OTP code is valid" do
      it "enables OTP and renders the success page" do
        otp_code = "123456"
        allow_any_instance_of(User).to(receive(:validate_and_consume_otp!).with(otp_code).and_return(true))
        post two_factor_authentication_confirmation_path, params: { otp_code: otp_code }

        expect(response).to(have_http_status(:success))
        expect(flash[:alert]).to(be_nil)

        # Additional assertions for enabling OTP and generating backup codes
        user.reload
        expect(user).to(be_otp_required_for_login)
        expect(user.otp_backup_codes.count).to(eq(12))
      end
    end
  end
end
