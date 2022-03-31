# frozen_string_literal: true

require_relative '../modules/site_toolbar'
module TestingSiteOnlyoffice
  # /contacts.aspx
  # https://user-images.githubusercontent.com/67409742/161008206-d2549459-38c5-457e-bc75-2f59535e6c3d.png
  class SiteContacts
    include PageObject
    include SiteToolbar

    element(:header_page, xpath: '//div[@class="description"]/h1')
    elements(:regions_office, xpath: '//span[@class="region"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(header_page_element) }
      return true if @instance.webdriver.get_text(header_page_element) == 'Contact information'

      @instance.webdriver.webdriver_error("The page 'About contacts' didn't load or doesn't match the title")
    end

    def region_office
      @instance.webdriver.get_text_array(regions_office_elements)
    end

    def comparison_region_office
      region_office == ['US office', 'Latvian office', 'UK office']
    end
  end
end
