# frozen_string_literal: true

module TestingSiteOnlyoffice
  class SiteForum
    include PageObject

    link(:forum_logo, xpath: '//*[@id="logo"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        forum_logo_visible?
      end
    end

    def forum_logo_visible?
      forum_logo_element.present?
    end
  end
end
