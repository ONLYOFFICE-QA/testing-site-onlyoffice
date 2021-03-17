require_relative 'portal_people'
require_relative 'portal_version'
require_relative 'portal_mail'
require_relative 'teamlab_portal_reg_web_helper'
require_relative 'portal_helper/portal_reg_api_helper'

module TestingSiteOnlyoffice
  class PortalHelper
    include PortalPeople
    include PortalVersion
    include PortalMail
    include TeamlabPortalRegWebHelper
    include PortalRegAPIHelper

    def init_portal(portal_creation_data, language = StaticDataTeamLab.current_language)
      if StaticDataTeamLab.custom_portal_flag
        StaticDataTeamLab.custom_user_list
      elsif portal_creation_data.custom_portal_flag
        portal_creation_data.custom_user_list
      elsif portal_creation_data.reg_via_api
        reg_portal_via_api(portal_creation_data, true, language)
      else
        create_portal_by_web(portal_creation_data, true, language)
      end
    end

    def init_instance(admin, change_language_flag = false, language = StaticDataTeamLab.current_language)
      test = TestInstance.new(admin)
      if test.webdriver.get_page_source.include?('Error 503')
        test.webdriver.webdriver_error('HTTP Error 503. Service Unavailable')
      end
      if StaticDataTeamLab.personal_portals.include?(admin.portal)
        login_page = LoginPagePersonal.new(test)
        [login_page.login_with, test]
      else
        login_page = LoginPage.new(test)
        @main_page = login_page.login_with
        change_language_current_portal(change_language_flag, language) if admin.type == :admin
        [@main_page, test]
      end
    end
  end
end
