# frozen_string_literal: true

require_relative 'site_document_builder_constructor'

module TestingSiteOnlyoffice
  # /download-builder.aspx
  # https://user-images.githubusercontent.com/38238032/197165244-46525b56-4b4f-423c-8640-5fec921cbf61.png
  class SiteGetOnlyofficeDownloadDocBuilder
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
