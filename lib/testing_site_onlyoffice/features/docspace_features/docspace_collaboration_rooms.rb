# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /collaboration-rooms.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/c7ba3c9d-afb1-422f-a42f-c67e4e6dab2d
  class DocspaceCollaborationRooms
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
