# frozen_string_literal: true

require_relative '../get_onlyoffice/site_docspace_sign_up'
require_relative '../features/connectors/site_connectors_zoom'
require_relative 'modules/site_doc_space_main_page_helper'

module TestingSiteOnlyoffice
  # /docspace.aspx
  # https://user-images.githubusercontent.com/38238032/234249398-9516b541-d981-4801-9600-e4b61baa049f.jpg
  class SiteDocSpaceMainPage
    include PageObject
    include SiteEditorsLinksCheckingHelper
    include SiteDocSpaceMainPageHelper

    link(:docspace_registration_button, xpath: '//a[@id = "account-btn" and @href = "/docspace-registration.aspx"]')
    link(:startups_free_cloud, xpath: '//a[@class = "third-icon choice_item" and @href = "/docspace-registration.aspx"]')
    link(:business_check_prices, xpath: '//a[@class="first-icon choice_item" and @href = "/docspace-prices.aspx#docspace-cloud"]')
    link(:enterprise_get_it_now, xpath: '//a[@class = "second-icon choice_item" and @href = "/download-docspace.aspx#docspace-enterprise"]')
    link(:start_free_cloud, xpath: '//a[@id = "docspace_docspace_registration_start_with_your_free_account"]')
    link(:download_pc, xpath: "((//div[contains(@class, 's_block')])[4]")
    link(:install_mobile, xpath: "((//div[contains(@class, 's_block')])[5]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docspace_registration_button_element) }
    end
  end
end
