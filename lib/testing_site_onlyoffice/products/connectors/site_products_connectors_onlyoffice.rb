# /all-connectors.aspx for developed by onlyoffice
# https://user-images.githubusercontent.com/40513035/116680142-2e14c600-a960-11eb-8c87-746906a7db86.png
require_relative 'modules/site_connectors_toolbar'
require_relative 'site_connectors_constructor'
require_relative 'site_connectors_more_info'
require_relative '../../get_onlyoffice/modules/site_block_constructor_helper'
require_relative '../../get_onlyoffice/modules/site_download_helper'
require_relative '../../get_onlyoffice/open_source_packages/connectors/site_open_source_connectors'
require_relative '../../site_home_page'

module TestingSiteOnlyoffice
  class SiteProductsConnectorsOnlyoffice
    include PageObject
    include SiteConnectorsToolbar
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
        chamilo_get_it_now_xpath = onlyoffice_connector_block.get_it_now_xpath
        @instance.webdriver.get_element(chamilo_get_it_now_xpath).present?
      end
    end

    def onlyoffice_connector_block(connector = :chamilo)
      block_xpath = "//div[@class='integration_own_downloads']"
      SiteProductsConnectorConstructor.new(@instance, block_xpath, connector.to_s)
    end

    def click_get_it_now_link(xpath)
      @instance.webdriver.get_element(xpath).click
      SiteOpenSourceConnectors.new(@instance)
    end

    def click_more_info_link(xpath, connector)
      @instance.webdriver.get_element(xpath).click
      SiteConnectorsMoreInfo.new(@instance, connector)
    end

    def onlyoffice_opened?
      @instance.webdriver.choose_tab(2)
      SiteHomePage.new(@instance)
    end
  end
end
