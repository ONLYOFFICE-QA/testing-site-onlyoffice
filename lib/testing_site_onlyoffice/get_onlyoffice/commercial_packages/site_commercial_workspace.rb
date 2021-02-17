# Commercial workspace packages
# https://user-images.githubusercontent.com/40513035/99003720-9822e580-254f-11eb-9cd5-2b0c7a966d95.png
require_relative '../../modules/site_toolbar'
require_relative 'modules/site_commercial_toolbar'
require_relative '../modules/site_download_helper'
require_relative 'site_commercial_block_constructor'
require_relative 'modules/site_commercial_download_helper'

module TestingSiteOnlyoffice
  class SiteCommercialWorkspace
    include PageObject
    include SiteDownloadHelper
    include SiteCommercialDownloadHelper
    include SiteToolbar
    include SiteToolbarCommercial

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
