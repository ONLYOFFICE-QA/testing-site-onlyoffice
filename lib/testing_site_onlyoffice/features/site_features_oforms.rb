# frozen_string_literal: true

module TestingSiteOnlyoffice
  # https://oforms.onlyoffice.com
  # https://user-images.githubusercontent.com/38238032/196736104-45dbc113-c01a-4138-96d3-94685686b5c7.png
  class SiteFeaturesOforms
    include PageObject
    include SiteToolbar

    div(:info_editors_block, xpath: '//div[contains(@class, "category-nav")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(info_editors_block_element)
      end
    end
  end
end
