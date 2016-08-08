Clearance.configure do |config|
  config.routes = false
  config.allow_sign_up = true
  config.cookie_domain = ".chengbnb.com"
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.cookie_name = "remember_token"
  config.cookie_path = "/"
  config.httponly = false
  config.mailer_sender = "reply@chengbnb.com"
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = "/"
  config.secure_cookie = false
  config.sign_in_guards = []
  config.user_model = User
end