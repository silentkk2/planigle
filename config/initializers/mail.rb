# Email settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {  
  :address => "<Replace with SMTP Server hostname>",
  :port => 25,
  :domain => "<Replace with SMTP Server domain>",
  }

require 'individual_mailer'
IndividualMailer.admin_email = '<Replace with Admin Email Address>'   # The email address to send from
IndividualMailer.site = '<Replace with web site host[:port]>'           # The host[:port] of the server (for URLs)