# Module for code for password forgot function

module TestingSiteOnlyffice
  module ForgotPasswordHelper
    # @return [IredMailHelper] mail to send forgotten password
    def mail_for_forgotten_password
      @mail_for_forgotten_password ||= IredMailHelper.new(username: 'portal-forgot-password@qamail.teamlab.info',
                                                          password: 'qQe9C4vxSy5mbUMP6kCm')
    end

    # @return [String] portal on which forgot password
    def portal_of_forgotten_password
      case StaticDataTeamLab.server_region
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
