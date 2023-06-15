# frozen_string_literal: true

require "rails_helper"

RSpec.describe(TwoFactorAuthenticationsController, type: :request) do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /two_factor_authentication" do
    it "renders the show template" do
      get two_factor_authentication_path
      expect(response).to(have_http_status(200))
    end
  end

  describe "POST /two_factor_authentication" do
    it "creates OTP secret and renders the confirmation template" do
      post two_factor_authentication_path
      expect(response).to(have_http_status(200))
      expect(user.reload.otp_secret).not_to(be_nil)
      expect(user.reload.otp_backup_codes).to(be_empty)
    end
  end

  describe "DELETE /two_factor_authentication" do
    it "disables two-factor authentication and redirects to the show page" do
      user.update(otp_required_for_login: true, otp_backup_codes: ["code1", "code2"])

      delete two_factor_authentication_path
      expect(response).to(redirect_to(two_factor_authentication_path))

      expect(user.reload.otp_required_for_login).to(be_falsey)
      expect(user.reload.otp_backup_codes).to(be_empty)
    end
  end
end
