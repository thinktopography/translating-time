options = YAML.load_file("#{Rails.root}/config/smtp.yml")[Rails.env].symbolize_keys

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {}
ActionMailer::Base.smtp_settings[:address] = options[:address]
ActionMailer::Base.smtp_settings[:port] = options[:port]
ActionMailer::Base.smtp_settings[:domain] = options[:domain]
ActionMailer::Base.smtp_settings[:user_name] = options[:username] unless options[:username].blank?
ActionMailer::Base.smtp_settings[:password] = options[:password] unless options[:password].blank?
ActionMailer::Base.smtp_settings[:authentication] = options[:authentication] unless options[:authentication].blank?
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = options[:tls] unless options[:tls].blank?