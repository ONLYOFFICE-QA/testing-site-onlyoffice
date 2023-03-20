# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../modules/open_source/site_installer_block_constructor'

module TestingSiteOnlyoffice
  # /download-docs.aspx?from=downloadintegrationmenu#docs-community
  # https://user-images.githubusercontent.com/40513035/131093555-b4c45fb2-a30c-48ca-a6a9-fb20d4b92045.png
  class SiteGetOnlyofficeDocsCommunity
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        docker_instruction_xpath = installer_type_block.instruction_xpath
        @instance.webdriver.element_present?(docker_instruction_xpath)
      end
    end

    def installer_type_block(type = :docker)
      SiteBlockConstructor.new(@instance, 'docs-community', type.to_s)
    end

    def install_button_works?(installer)
      downloaded_installer = SiteDownloadData.open_source_docs_info[installer.to_s]['download']
      if installer == :windows
        file_downloaded?(downloaded_installer)
      else
        @instance.webdriver.wait_until { !check_opened_page_title.empty? } # Digitalocean title loading timeout
        check_opened_page_title == downloaded_installer
      end
    end
  end
end
