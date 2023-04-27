# frozen_string_literal: true

require_relative '../get_onlyoffice/site_docspace_registration'
module TestingSiteOnlyoffice
  # /docspace.aspx
  # https://user-images.githubusercontent.com/38238032/234249398-9516b541-d981-4801-9600-e4b61baa049f.jpg
  class SiteDocSpaceMainPage
    include PageObject

    link(:docspace_registration_button, xpath: '//div[contains(@class, "contentConteiner")]//a[@href = "/docspace-registration.aspx"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docspace_registration_button_element) }
    end

    def click_registration_button
      docspace_registration_button_element.click
      SiteDocSpaceRegistration.new(@instance)
    end
  end
end
