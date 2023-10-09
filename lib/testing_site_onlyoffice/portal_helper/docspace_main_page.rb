# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Class for main page of Docspace
  # https://user-images.githubusercontent.com/38238032/217225317-0d13fc43-8d2a-44de-80a6-91b440dbebfd.png
  class DocSpaceMainPage
    include PageObject

    button(:create_room_button, xpath: '//button[@id = "rooms-shared_create-room-button"]')
    div(:user_options_button, xpath: '//div[@id = "user-option-button"]')
    div(:user_avatar_icon, xpath: '//div[@id = "user-avatar"]')
    paragraph(:user_name, xpath: '//div[@id = "user-option-button"]//preceding-sibling::div/p[1]')
    paragraph(:user_surname, xpath: '//div[@id = "user-option-button"]//preceding-sibling::div/p[2]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(create_room_button_element) }
    end

    def user_full_name
      "#{user_name}#{user_surname}"
    end
  end
end
