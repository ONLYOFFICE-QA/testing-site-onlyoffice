# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /custom-rooms.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/b8dcfc6a-917f-445f-ad58-8f3ce5ce3556
  class DocspaceCustomRooms
    include PageObject

    link(:docspace_registration_button, xpath: '//div[@class = "rooms_header_text"]//a[@href = "/docspace-registration.aspx"]')
    element(:room_image, xpath: "//div[contains(@class, 'rooms-img ')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(docspace_registration_button_element)
      end
    end
  end
end
