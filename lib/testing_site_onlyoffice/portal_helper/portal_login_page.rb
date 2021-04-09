# Portal Login page
# https://user-images.githubusercontent.com/40513035/113820223-401f9200-972f-11eb-963a-5d4dedbd7e34.png
require_relative 'portal_main_page'

module TestingSiteOnlyoffice
  class PortalLoginPage
    include PageObject

    text_field(:mail, id: 'login')
    text_field(:password, id: 'pwd')
    link(:login, id: 'loginButton')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        login_element.present?
      end
    end

    def login_with(username = @instance.user.mail, password = @instance.user.pwd)
      self.mail = username
      self.password = password
      login_element.click
      PortalMainPage.new(@instance)
    end
  end
end
