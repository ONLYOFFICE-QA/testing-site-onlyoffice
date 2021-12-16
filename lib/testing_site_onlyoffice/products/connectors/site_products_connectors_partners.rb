# frozen_string_literal: true

require_relative 'site_connectors_constructor'
require_relative '../../get_onlyoffice/modules/site_block_constructor_helper'
require_relative '../../get_onlyoffice/modules/site_download_helper'

module TestingSiteOnlyoffice
  # /all-connectors.aspx for developed by partners
  # https://user-images.githubusercontent.com/40513035/116680005-0887bc80-a960-11eb-82cb-b8327c4c5298.png
  class SiteProductsConnectorsPartners
    include PageObject
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteToolbar

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        ecmind_get_it_now_xpath = partners_connector_block.get_it_now_xpath
        @instance.webdriver.element_present?(ecmind_get_it_now_xpath)
      end
    end

    def partners_connector_block(connector = :ecmind)
      block_xpath = "//div[@class='integration_thirdparty_downloads']"
      SiteProductsConnectorConstructor.new(@instance, block_xpath, connector.to_s)
    end
  end
end
