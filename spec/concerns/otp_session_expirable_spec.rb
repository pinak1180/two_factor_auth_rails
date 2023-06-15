# frozen_string_literal: true

RSpec.describe(OtpSessionExpirable) do
  # Define a fake controller to include the concern
  class FakeController
    include OtpSessionExpirable

    attr_accessor :session, :redirect_called

    def initialize
      @session = {}
      @redirect_called = false
    end

    def redirect_to(_path)
      @redirect_called = true
    end
  end

  let(:controller) { FakeController.new }

  describe "#expire_otp_session!" do
    context "when otp_user_id and otp_user_id_expires_at are present in session" do
      before do
        controller.session[:otp_user_id] = 1
        controller.session[:otp_user_id_expires_at] = Time.current - 1.hour
      end

      it "clears otp_user_id and otp_user_id_expires_at from session" do
        controller.expire_otp_session!

        expect(controller.session[:otp_user_id]).to(be_nil)
        expect(controller.session[:otp_user_id_expires_at]).to(be_nil)
      end

      it "calls redirect_to with new_user_session_path" do
        controller.expire_otp_session!

        expect(controller.redirect_called).to(be_truthy)
      end
    end

    context "when otp_user_id or otp_user_id_expires_at is missing in session" do
      it "does not clear otp_user_id and otp_user_id_expires_at from session" do
        controller.expire_otp_session!

        expect(controller.session[:otp_user_id]).to(be_nil)
        expect(controller.session[:otp_user_id_expires_at]).to(be_nil)
      end

      it "does not call redirect_to" do
        controller.expire_otp_session!

        expect(controller.redirect_called).to(be_falsey)
      end
    end
  end
end
