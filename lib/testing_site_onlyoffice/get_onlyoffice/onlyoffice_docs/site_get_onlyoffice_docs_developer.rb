# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../modules/site_block_constructor_helper'
require_relative '../modules/commercial/site_commercial_block_constructor'
require_relative '../modules/commercial/site_commercial_download_helper'

module TestingSiteOnlyoffice
  # /download-docs.aspx?from=downloadintegrationmenu#docs-developer
  # https://user-images.githubusercontent.com/40513035/130984588-cd3337ef-e4d4-47d4-9860-531ee8839e50.png
  class SiteGetOnlyofficeDocsDeveloper
    include PageObject
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteCommercialDownloadHelper
    include SiteToolbar

    element(:title_docs_developer, xpath: "//div[@class='dwn-mp-docs-developer']/h2")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        docker_download_xpath = installer_docs_developer_type_block.download_xpath
        @instance.webdriver.element_present?(docker_download_xpath)
      end
    end

    def installer_docs_developer_type_block(type = :docker)
      SiteCommercialBlockConstructor.new(@instance, 'docs_developer', type.to_s)
    end

    def page_title
      @instance.webdriver.get_text(title_docs_developer_element)
    end
  end
end
