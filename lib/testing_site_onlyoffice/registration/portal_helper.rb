require_relative 'portal_people'
require_relative 'portal_version'

module TestingSiteOnlyoffice
  class PortalHelper
    include PortalPeople
    include PortalVersion

    def init_instance(admin)
      test = TestInstance.new(admin)
      if test.webdriver.get_page_source.include?('Error 503')
        test.webdriver.webdriver_error('HTTP Error 503. Service Unavailable')
      end
      login_page = LoginPage.new(test)
      @main_page = login_page.login_with
      [@main_page, test]
    end
  end
end
