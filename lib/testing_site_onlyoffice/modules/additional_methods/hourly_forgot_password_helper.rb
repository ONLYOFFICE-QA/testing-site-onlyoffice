# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Module for code for password forgot function
  module HourlyForgotPasswordHelper
    # @return [IredMailHelper] mail to send forgotten password
    def mail_for_forgotten_password
      @mail_for_forgotten_password ||= OnlyofficeIredmailHelper::IredMailHelper.new(username: 'portal-forgot-password@qamail.teamlab.info',
                                                                                    password: @instance.private_data['mail_portal-forgot-password_pass'])
    end

    def portal_for_hourly_forgotten_password
      case config.region
      when 'us'
        'https://nctautotest-site-forgot-password-us.onlyoffice.com'
      when 'eu'
        'https://nctautotest-site-forgot-password.onlyoffice.eu'
      when 'sg'
        'https://nctautotest-site-forgot-password-sg.onlyoffice.sg'
      else
        raise 'Unknown server region'
      end
    end
  end
end
