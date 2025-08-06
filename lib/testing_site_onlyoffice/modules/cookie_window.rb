# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Handle operations with cookie window
  # https://user-images.githubusercontent.com/668524/64252317-3d413780-cf23-11e9-9ec8-503c5c3bdb82.png
  module CookieWindow
    include PageObject

    link(:cookie_button, xpath: '//a[@id="acceptCookies"]')

    # @return [True, False] is cookie warning shown
    def cookie_warning_shown?
      cookie_button_element.visible?
    end

    # @return [Nothing] agree with cookie window if shown
    def agree_with_cookie_if_shown
      cookie_button_element.click if cookie_warning_shown?
    end
  end
end
