
# The 2FA feature contains several flows:
1 Setup flow

2 Enable OTP-based two-factor authentication


3 Disable 2FA


4 Regenerate recovery codes


5 Login flow


6 Login with OTP


7 Login with recovery code


## Problem In Existing 2FA devise-two-factor gem
  1: The default way of devise-two-factor to do two-factor authentication is to put the email, password, and OTP field on the same page. However, this is not the most common way to do 2FA login.



  2: The common way is to allow users to sign in with or without 2FA. So we need to submit email and password first, then submit the 6 digit OTP code on the second page.
  We need to do some customization based on devise-two-factor gem:


## Customization Implementation
 1 Replace devise-two-factor two_factor_authenticatable strategy with otp_attempt_authenticatable  [otp_attempt_strategy](https://github.com/pinak1180/two_factor_auth_rails/blob/main/lib/devise-two-factor/strategies/otp_attempt_authenticatable.rb)

 2 Replace devise-two-factor two_factor_backupable strategy with recovery_code_authenticatable  [recovery_code_strategy](https://github.com/pinak1180/two_factor_auth_rails/blob/main/lib/devise-two-factor/strategies/recovery_code_authenticatable.rb)


## Screenshots
Login Page
![image](https://github.com/pinak1180/two_factor_auth_rails/assets/3368193/ed09474d-a90a-4258-8eb7-a4988078233e)

successfull login/signup

![image](https://github.com/pinak1180/two_factor_auth_rails/assets/3368193/f7b2b922-f89c-4238-aa03-421377978d4c)

Enable 2FA via app

![image](https://github.com/pinak1180/two_factor_auth_rails/assets/3368193/5282103d-b5c7-4a66-a727-a8caaefd2c11)

Scan the Qr and validate the otp

![image](https://github.com/pinak1180/two_factor_auth_rails/assets/3368193/39ebe4cf-1aa4-4676-a483-0e19538dee15)

successfull activation leads to backup codes

![image](https://github.com/pinak1180/two_factor_auth_rails/assets/3368193/1f073503-94fb-48d6-8b2b-0ea74df7edcf)


option to disable 2fa & regenerate backup codes 

![image](https://github.com/pinak1180/two_factor_auth_rails/assets/3368193/180a3d12-448a-41d3-acd4-7f4b88700734)

2 form flow for 2fa login after successfully adding username and password

![image](https://github.com/pinak1180/two_factor_auth_rails/assets/3368193/26bc6130-8451-4aed-a97f-6b5a5ea368a6)



## Limitations 

1: Only support Totp (Time-based One-time Password) for now.

2: Added Helper for system test so it is fairly easy to add system test now but it is not added for now.


