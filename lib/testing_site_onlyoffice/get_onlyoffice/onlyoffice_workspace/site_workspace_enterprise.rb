# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../modules/site_block_constructor_helper'
require_relative '../modules/commercial/site_commercial_block_constructor'
require_relative '../modules/commercial/site_commercial_download_form'
require_relative 'modules/onlyoffice_workspace_toolbar'

module TestingSiteOnlyoffice
  # /download-workspace.aspx#workspace-enterprise
  # https://user-images.githubusercontent.com/40513035/131041987-ec65d0f6-c96e-43f2-b3ab-cafd8c6b9a09.png
  class SiteWorkspaceEnterprise
    include PageObject
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteCommercialDownloadHelper
    include SiteToolbar
    include SiteToolbarOnlyofficeWorkspace

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        docker_download_xpath = installer_type_block.download_xpath
        @instance.webdriver.get_element(docker_download_xpath).present?
      end
    end

    def installer_type_block(type = :docker)
      SiteCommercialBlockConstructor.new(@instance, 'workspace_enterprise', type.to_s)
    end
  end
end
