# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /docspace-registration.aspx
  # https://user-images.githubusercontent.com/38238032/234256489-08d104ea-ceed-4735-a394-e30fd991bb2f.jpg
  class SiteDocSpaceRegistration
    include PageObject

    div(:signup_form, xpath: '//div[contains(@class, "signuppageform")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(signup_form_element) }
    end
  end
end
