
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

![image](https://www.awesomescreenshot.com/image/40783543?key=3435942081f6ec555e379f6e980b8d90)






## Limitations 

1: Only support Totp (Time-based One-time Password) for now.

2: Added Helper for system test so it is fairly easy to add system test now but it is not added for now.


