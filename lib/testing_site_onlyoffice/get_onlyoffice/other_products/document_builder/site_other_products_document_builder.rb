# frozen_string_literal: true

require_relative '../../../modules/site_toolbar'
require_relative '../modules/other_products_toolbar'
require_relative '../../modules/site_download_helper'
require_relative '../../modules/site_block_constructor_helper'
require_relative 'site_document_builder_constructor'

module TestingSiteOnlyoffice
  # /download.aspx#builder
  # https://user-images.githubusercontent.com/40513035/131142257-9a25026f-9131-4835-99b8-ef23134d1637.png
  class SiteOtherProductsDocumentBuilder
    include PageObject
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteToolbar
    include SiteOtherProductsToolbar

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        windows_instruction_xpath = installer_document_builder_block.instruction_xpath
        @instance.webdriver.element_present?(windows_instruction_xpath)
      end
    end

    def installer_document_builder_block(type = :windows)
      SiteDocumentBuilderConstructor.new(@instance, type.to_s)
    end
  end
end
