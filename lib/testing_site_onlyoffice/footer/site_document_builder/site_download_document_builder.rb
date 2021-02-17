# /download-document-builder.aspx
# https://user-images.githubusercontent.com/40513035/100556307-84e37a00-32b2-11eb-8b00-7f3b628aaa00.png
require_relative 'site_document_builder_block_constructor'
require_relative '../../get_onlyoffice/modules/site_download_helper'

module TestingSiteOnlyoffice
  class SiteDownloadDocumentBuilder
    include PageObject
    include SiteDownloadHelper

    link(:rpm_package_switch, xpath: '//a[contains(@class, "button_rpm")]')
    link(:deb_package_switch, xpath: '//a[contains(@class, "button_deb")]')

    link(:fork_me_on_github, xpath: '//a[@class="btnGitHub button white"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        windows_download_xpath = installer_document_builder_type_block.download_xpath
        @instance.webdriver.get_element(windows_download_xpath).present?
      end
    end

    def switch_to_rpm
      return if rpm_currently_selected?

      rpm_package_switch_element.click
      @instance.webdriver.wait_until { rpm_currently_selected? }
    end

    def rpm_currently_selected?
      rpm_package_switch_element.attribute_value('class').include?('currently_selected')
    end

    def switch_to_deb
      return if deb_currently_selected?

      deb_package_switch_element.click
      @instance.webdriver.wait_until { deb_currently_selected? }
    end

    def deb_currently_selected?
      deb_package_switch_element.attribute_value('class').include?('currently_selected')
    end

    def installer_document_builder_type_block(type = :windows)
      switch_to_rpm if type == :rpm
      SiteDocumentBuilderBlockConstructor.new(@instance, type.to_s)
    end
  end
end
