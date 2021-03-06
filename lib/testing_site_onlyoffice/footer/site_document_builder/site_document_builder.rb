# frozen_string_literal: true

require_relative '../../get_onlyoffice/open_source_packages/document_builder/site_open_source_document_builder'

module TestingSiteOnlyoffice
  # /document-builder.aspx
  # https://user-images.githubusercontent.com/668524/68375334-ba716e80-0157-11ea-9a82-807f8464db7a.png
  class SiteDocumentBuilder
    include PageObject

    # identification
    element(:aspnet_builder, xpath: '//form[contains(@action, "/document-builder")]')

    # download links
    link(:download_now, xpath: '//a[contains(@class, "button red")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { aspnet_builder_element.present? }
    end

    def click_download_now
      download_now_element.click
      SiteOpenSourceDocumentBuilder.new(@instance)
    end
  end
end
