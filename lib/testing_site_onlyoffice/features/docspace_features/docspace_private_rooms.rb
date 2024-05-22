# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /private-rooms.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/4dc91883-4a2f-4ee0-b8bf-d301c589c22b
  class DocspacePrivateRooms
    include PageObject

    link(:docspace_registration_button, xpath: '//a[@id = "account-btn" and @href = "/docspace-registration.aspx"]')
    div(:private_rooms_header, xpath: "//div[@id = 'privateroompage']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(private_rooms_header_element) }
    end
  end
end
