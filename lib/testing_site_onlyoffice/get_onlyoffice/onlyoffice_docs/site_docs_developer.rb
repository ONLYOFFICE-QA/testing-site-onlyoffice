# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'modules/onlyoffice_docs_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../modules/site_block_constructor_helper'
require_relative '../modules/commercial/site_commercial_block_constructor'
require_relative '../modules/commercial/site_commercial_download_helper'

module TestingSiteOnlyoffice
  # /download-docs.aspx?from=downloadintegrationmenu#docs-developer
  # https://user-images.githubusercontent.com/40513035/130984588-cd3337ef-e4d4-47d4-9860-531ee8839e50.png
  class SiteDocsDeveloper
    include PageObject
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteCommercialDownloadHelper
    include SiteToolbar
    include SiteToolbarOnlyofficeDocs

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        docker_download_xpath = installer_docs_developer_type_block.download_xpath
        @instance.webdriver.get_element(docker_download_xpath).present?
      end
    end

    def installer_docs_developer_type_block(type = :docker)
      SiteCommercialBlockConstructor.new(@instance, 'docs_developer', type.to_s)
    end
  end
end
