require_relative 'portal_version'
require_relative 'portal_test_instance'
require_relative 'portal_login_page'

module TestingSiteOnlyoffice
  class PortalHelper
    include PortalVersion

    def open_and_login_to_portal(admin, portal_url)
      instance = PortalTestInstance.new(config, portal_url)
      login_page = PortalLoginPage.new(instance)
      @main_page = login_page.login_with(admin[:email], admin[:password])
      [@main_page, instance]
    end
  end
end
