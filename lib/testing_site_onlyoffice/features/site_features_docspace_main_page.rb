# frozen_string_literal: true

require_relative '../get_onlyoffice/site_docspace_sign_up'
require_relative '../features/connectors/site_connectors_zoom'
require_relative 'modules/site_doc_space_main_page_helper'
require_relative 'docspace_features/docspace_collaboration_rooms'
require_relative 'docspace_features/docspace_custom_rooms'
require_relative 'docspace_features/docspace_private_rooms'
require_relative 'docspace_features/docspace_public_rooms'

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
    link(:collaboration_rooms_learn_more, xpath: '(//div[@class = "ds-tb-area"]//a[@href ="/collaboration-rooms.aspx"])[1]')
    element(:public_rooms, xpath: "(//li[@role='presentation'])[3]")
    link(:public_rooms_learn_more, xpath: '(//div[@class = "ds-tb-area"]//a[@href ="/public-rooms.aspx"])[1]')
    element(:custom_rooms, xpath: "(//li[@role='presentation'])[4]")
    link(:custom_rooms_learn_more, xpath: '(//div[@class = "ds-tb-area"]//a[@href ="/custom-rooms.aspx"])[1]')
    element(:private_rooms, xpath: "(//li[@role='presentation'])[5]")
    link(:private_rooms_learn_more, xpath: '(//div[@class = "ds-tb-area"]//a[@href ="/private-rooms.aspx"])[2]')

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
