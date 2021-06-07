# frozen_string_literal: true

require_relative '../modules/site_toolbar'

module TestingSiteOnlyoffice
  # https://helpcenter.onlyoffice.com/
  # https://user-images.githubusercontent.com/40513035/120973953-6f00b700-c724-11eb-83ed-2dd1ac2eb098.png
  class SiteHelpCenter
    attr_accessor :instance

    include PageObject

    link(:headers_menu, xpath: '//nav//a[@class="menuitem"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        help_center_site_map_visible?
      end
    end

    def help_center_site_map_visible?
      headers_menu_element.present?
    end
  end
end
