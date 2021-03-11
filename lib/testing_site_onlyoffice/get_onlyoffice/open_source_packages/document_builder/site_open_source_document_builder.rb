# Open source packages for document builder
# https://user-images.githubusercontent.com/40513035/110755500-14a5a680-825a-11eb-960c-7eb9a3d58c8e.png

require_relative '../../../modules/site_toolbar'
require_relative '../modules/site_open_source_toolbar'
require_relative '../../modules/site_download_helper'
require_relative 'site_document_builder_constructor'

module TestingSiteOnlyoffice
  class SiteOpenSourceDocumentBuilder
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarOpenSource

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        windows_instruction_xpath = installer_document_builder_block.instruction_xpath
        @instance.webdriver.get_element(windows_instruction_xpath).present?
      end
    end

    def installer_document_builder_block(type = :windows)
      SiteDocumentBuilderConstructor.new(@instance, type.to_s)
    end
  end
end
