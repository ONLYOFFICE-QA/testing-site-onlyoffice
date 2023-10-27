# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../modules/site_block_constructor_helper'
require_relative '../modules/commercial/site_commercial_block_constructor'
require_relative '../modules/commercial/site_commercial_download_helper'

module TestingSiteOnlyoffice
  # /download-docs.aspx?from=downloadintegrationmenu#docs-enterprise
  # https://user-images.githubusercontent.com/40513035/130984556-c809e161-d96f-448c-9e44-63bf82600123.png
  class SiteGetOnlyofficeDocsEnterprise
    include PageObject
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteCommercialDownloadHelper
    include SiteToolbar

    element(:title_docs_enterprise, xpath: "//div[@class='dwn-mp-docs-enterprise']/h2")
    element(:log_errors, xpath: "//span[@id='logEmptyDetailsDatas']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        docker_download_xpath = installer_docs_enterprise_type_block.download_xpath
        @instance.webdriver.element_present?(docker_download_xpath)
      end
    end

    def installer_docs_enterprise_type_block(type = :docker)
      SiteCommercialBlockConstructor.new(@instance, 'docs_enterprise', type.to_s)
    end

    def page_title
      @instance.webdriver.get_text(title_docs_enterprise_element)
    end

    def empty_text_log?
      true if @instance.webdriver.get_text(log_errors_element).empty?
    end
  end
end
