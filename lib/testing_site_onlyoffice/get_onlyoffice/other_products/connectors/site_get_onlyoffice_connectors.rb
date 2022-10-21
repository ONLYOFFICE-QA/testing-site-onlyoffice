# frozen_string_literal: true

require_relative '../../../modules/site_toolbar'
require_relative '../../modules/site_download_helper'
require_relative '../../modules/site_block_constructor_helper'
require_relative '../modules/other_products_toolbar'
require_relative 'site_connectors_constructor'
require_relative 'site_connectors_github_data'
require_relative 'site_connector_release_data'

module TestingSiteOnlyoffice
  # /download-connectors.aspx
  # https://user-images.githubusercontent.com/38238032/197178405-328ddcc3-9d3d-4757-b1ad-78974792f814.png
  class SiteGetOnlyofficeConnectors
    include PageObject
    include SiteBlockConstructorHelper
    include SiteConnectorsGithubData
    include SiteDownloadHelper
    include SiteToolbar
    include SiteOtherProductsToolbar

    div(:connector_block, xpath: "//div[@class='dwn-mp-connectors']//div[@class='dwn-mp-item']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        alfresco_github_xpath = installer_open_source_connector_block.get_on_github_xpath
        @instance.webdriver.element_present?(alfresco_github_xpath)
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
