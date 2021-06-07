# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'modules/site_commercial_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../modules/site_block_constructor_helper'
require_relative 'site_commercial_block_constructor'
require_relative 'modules/site_commercial_download_helper'

module TestingSiteOnlyoffice
  # Commercial docs packages
  # https://user-images.githubusercontent.com/40513035/99003524-437f6a80-254f-11eb-8e26-d94e73ea2a9c.png
  class SiteCommercialDocs
    include PageObject
    include SiteBlockConstructorHelper
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
        docker_download_xpath = installer_docs_enterprise_type_block.download_xpath
        @instance.webdriver.get_element(docker_download_xpath).present?
      end
    end

    def installer_docs_enterprise_type_block(type = :docker)
      SiteCommercialBlockConstructor.new(@instance, 'docs_enterprise', type.to_s)
    end

    def installer_docs_developer_type_block(type = :docker)
      SiteCommercialBlockConstructor.new(@instance, 'docs_developer', type.to_s)
    end
  end
end
