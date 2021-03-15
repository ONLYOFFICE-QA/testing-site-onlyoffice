# Open source packages
# https://user-images.githubusercontent.com/40513035/95982402-c0240980-0e28-11eb-8690-711459dae4e3.png
require_relative '../../modules/site_toolbar'
require_relative 'modules/site_open_source_toolbar'
require_relative '../modules/site_download_helper'
require_relative 'site_installer_block_constructor'

module TestingSiteOnlyoffice
  class SiteOpenSourceDocs
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
        docker_instruction_xpath = installer_type_block.instruction_xpath
        @instance.webdriver.get_element(docker_instruction_xpath).present?
      end
    end

    def installer_type_block(type = :docker)
      SiteBlockConstructor.new(@instance, 'docs', type.to_s)
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
