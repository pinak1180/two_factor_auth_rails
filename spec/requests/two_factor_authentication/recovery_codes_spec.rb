# frozen_string_literal: true

require "rails_helper"

RSpec.describe(TwoFactorAuthentication::RecoveryCodesController, type: :request) do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "POST create" do
    it "generates OTP recovery codes and renders the index page" do
      post two_factor_authentication_recovery_codes_path

      expect(response).to(have_http_status(:success))
      expect(user.reload.otp_backup_codes.count).to(eq(12))
    end
  end

  describe "GET index" do
    it "redirects to the two-factor authentication path" do
      get two_factor_authentication_recovery_codes_path

      expect(response).to(redirect_to(two_factor_authentication_path))
    end
  end
end
