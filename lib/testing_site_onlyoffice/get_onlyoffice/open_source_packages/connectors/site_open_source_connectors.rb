# Connectors
# https://user-images.githubusercontent.com/40513035/96696620-a25c2480-1393-11eb-9f6b-4abba59d41b5.png
require_relative '../../../modules/site_toolbar'
require_relative '../../modules/site_download_helper'
require_relative '../../modules/site_block_constructor_helper'
require_relative '../modules/site_open_source_toolbar'
require_relative 'site_connectors_constructor'
require_relative 'site_connectors_github_data'
require_relative 'site_connector_release_data'

module TestingSiteOnlyoffice
  class SiteOpenSourceConnectors
    include PageObject
    include SiteBlockConstructorHelper
    include SiteConnectorsGithubData
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarOpenSource

    div(:connector_block, xpath: "//div[@class='dwn-mp-connectors']//div[@class='dwn-mp-item']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        alfresco_github_xpath = installer_open_source_connector_block.get_on_github_xpath
        @instance.webdriver.get_element(alfresco_github_xpath).present?
      end
    end

    def installer_open_source_connector_block(type = :alfresco)
      SiteConnectorsConstructor.new(@instance, type.to_s)
    end

    def connectors_block_number
      @instance.webdriver.driver.find_elements(:xpath, connector_block_element.selector[:xpath]).count
    end
  end
end
