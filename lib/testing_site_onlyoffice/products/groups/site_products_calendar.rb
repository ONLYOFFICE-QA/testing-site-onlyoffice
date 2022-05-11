# frozen_string_literal: true

require_relative '../modules/site_groups_xpath'
require_relative '../modules/site_products_methods'

module TestingSiteOnlyoffice
  # /calendar.aspx
  # https://user-images.githubusercontent.com/40513035/101333009-222c4880-3887-11eb-9abc-f716d57838ce.png
  class SiteProductsCalendar
    include PageObject
    include SiteGroupsXpath
    include SiteProductsMethods
    include SiteToolbar

    div(:calendar_identification, xpath: "//div[contains(@class,'collaborationcalendar')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(run_on_your_own_server_element) && @instance.webdriver.element_present?(calendar_identification_element)
      end
    end
  end
end
