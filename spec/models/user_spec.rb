# frozen_string_literal: true

require "rails_helper"

RSpec.describe(User, type: :model) do
  let(:user) { build(:user) }

  describe "validations" do
    it "validates presence of password on create" do
      user.password = nil
      expect(user.valid?(:create)).to(be(false))
      expect(user.errors[:password]).to(include("can't be blank"))
    end

    it "validates minimum password length on create" do
      user.password = "pass"
      expect(user.valid?(:create)).to(be(false))
      expect(user.errors[:password]).to(include("is too short (minimum is 8 characters)"))
    end

    it "validates password format on create" do
      user.password = "password"
      expect(user.valid?(:create)).to(be(false))
      expect(user.errors[:password]).to(include("is invalid"))

      user.password = "Password1!"
      expect(user.valid?(:create)).to(be(true))
    end

    it "validates password confirmation on create" do
      user.password = "Password1!"
      user.password_confirmation = "WrongPassword1!"
      expect(user.valid?(:create)).to(be(false))
      expect(user.errors[:password_confirmation]).to(include("doesn't match Password"))
    end

    it "validates minimum password length on update" do
      user.password = "pass"
      expect(user.valid?(:update)).to(be(false))
      expect(user.errors[:password]).to(include("is too short (minimum is 8 characters)"))
    end

    it "validates password format on update" do
      user.password = "password"
      expect(user.valid?(:update)).to(be(false))
      expect(user.errors[:password]).to(include("is invalid"))

      user.password = "Password1!"
      expect(user.valid?(:update)).to(be(true))
    end

    it "validates password confirmation on update" do
      user.password = "Password1!"
      user.password_confirmation = "WrongPassword1!"
      expect(user.valid?(:update)).to(be(false))
      expect(user.errors[:password_confirmation]).to(include("doesn't match Password"))
    end
  end

  describe "#otp_qrcode" do
    it "returns an instance of RQRCode::QRCode" do
      qr_code = user.otp_qrcode
      expect(qr_code).to(be_a(RQRCode::QRCode))
    end
  end
end
