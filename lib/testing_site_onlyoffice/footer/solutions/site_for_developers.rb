# frozen_string_literal: true

require_relative '../../get_onlyoffice/other_products/site_other_products_groups'
require_relative '../../get_onlyoffice/other_products/site_open_source_bundles'

module TestingSiteOnlyoffice
  # /for-developers.aspx
  # https://user-images.githubusercontent.com/38238032/197989071-7a9492ea-d66d-48c5-b7c2-d929c53218b9.png
  class SiteForDevelopers
    include PageObject
    include SiteOtherProductsToolbar

    link(:download_now_button, xpath: '//a[@href = "/download.aspx?from=for-developers"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(download_now_button_element)
      end
    end

    def click_download_now_button(destination)
      @instance.webdriver.click_on_locator(download_now_button_element)
      case destination
      when 'workspace'
        site_other_products_onlyoffice_groups_download
      when 'bundles'
        site_other_products_bundles_download
      end
    end
  end
end
