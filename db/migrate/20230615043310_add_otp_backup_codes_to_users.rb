# frozen_string_literal: true

class AddOtpBackupCodesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column(:users, :otp_backup_codes, :string, array: true, default: [])
  end
end
