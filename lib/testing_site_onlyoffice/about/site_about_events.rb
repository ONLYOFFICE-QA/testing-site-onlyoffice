# frozen_string_literal: true

require_relative '../modules/site_toolbar'
module TestingSiteOnlyoffice
  # /events.aspx
  # https://user-images.githubusercontent.com/67409742/145797300-b3a51c3f-197e-447c-8d40-90ef7761a815.png
  class SiteAboutEvents
    include PageObject

    div(:events_page, xpath: '//div[@class="events_header"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(events_page_element) }
    end
  end
end
