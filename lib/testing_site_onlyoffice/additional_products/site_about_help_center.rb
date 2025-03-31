# frozen_string_literal: true

require_relative '../modules/site_toolbar'

module TestingSiteOnlyoffice
  # https://helpcenter.onlyoffice.com/
  # https://user-images.githubusercontent.com/40513035/120973953-6f00b700-c724-11eb-83ed-2dd1ac2eb098.png
  class SiteAboutHelpCenter
    attr_accessor :instance

    include PageObject

    div(:headers_menu, xpath: '//div[@class="left-menu-wrapper"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until(wait_js: false) do
        help_center_site_map_visible?
      end
    end

    def help_center_site_map_visible?
      @instance.webdriver.element_present?(headers_menu_element)
    end
  end
end
