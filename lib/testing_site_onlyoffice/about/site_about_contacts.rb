# frozen_string_literal: true

require_relative '../modules/site_toolbar'
module TestingSiteOnlyoffice
  # /contacts.aspx
  # https://user-images.githubusercontent.com/67409742/161008206-d2549459-38c5-457e-bc75-2f59535e6c3d.png
  class SiteAboutContacts
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

    def list_of_offices_on_page
      @instance.webdriver.get_text_array(regions_office_elements)
    end

    def all_offices_present?
      list_of_offices_on_page == ['Singapore', 'U.S.A.', 'Latvia', 'United Kingdom', 'Armenia', 'Singapore', 'Uzbekistan', 'Serbia', 'China', 'Contact us']
    end
  end
end
