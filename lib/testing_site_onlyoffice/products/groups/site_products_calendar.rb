# /calendar.aspx
# https://user-images.githubusercontent.com/40513035/101333009-222c4880-3887-11eb-9abc-f716d57838ce.png
require_relative '../modules/site_groups_xpath'

module TestingSiteOnlyoffice
  class SiteProductsCalendar
    include PageObject
    include SiteGroupsXpath
    include SiteToolbar

    div(:calendar_identification, xpath: "//div[contains(@class,'collaborationcalendar')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        run_on_your_own_server_element.present? && calendar_identification_element.present?
      end
    end
  end
end
