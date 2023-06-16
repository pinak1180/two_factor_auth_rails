# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :two_factor_authenticatable,
    otp_secret_encryption_key: Rails.application.credentials.OTP_SECRET_ENCRYPTION_KEY

  devise :two_factor_backupable,
    otp_backup_code_length: 8,
    otp_number_of_backup_codes: 12

  PASSWORD_FORMAT = %r{\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
}x

  validates :password,
    presence: true,
    length: { in: Devise.password_length },
    format: { with: PASSWORD_FORMAT },
    confirmation: true,
    on: :create

  validates :password,
    allow_nil: true,
    length: { in: Devise.password_length },
    format: { with: PASSWORD_FORMAT },
    confirmation: true,
    on: :update

  def otp_qrcode
    provision_uri = otp_provisioning_uri(email, issuer: "two_factor_auth_rails")
    RQRCode::QRCode.new(provision_uri)
  end
end
