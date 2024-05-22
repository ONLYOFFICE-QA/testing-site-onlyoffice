# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /public-rooms.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/98da29da-c585-43a6-9e9c-dfe2a0f81528"
  class DocspacePublicRooms
    include PageObject

    link(:docspace_registration_button, xpath: '//div[@class = "rooms_header_text"]//a[@href = "/docspace-registration.aspx"]')
    link(:room_image, xpath: "//div[contains(@class, 'rooms-img ')]")

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
