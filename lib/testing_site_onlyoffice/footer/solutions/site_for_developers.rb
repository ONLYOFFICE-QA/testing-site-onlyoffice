# frozen_string_literal: true

require_relative '../../get_onlyoffice/other_products/site_other_products_groups'
require_relative '../../get_onlyoffice/other_products/site_open_source_bundles'
require_relative '../../for_developers/modules/site_for_developers_helper'

module TestingSiteOnlyoffice
  # /for-developers.aspx
  # https://user-images.githubusercontent.com/38238032/197989071-7a9492ea-d66d-48c5-b7c2-d929c53218b9.png
  class SiteForDevelopers
    include PageObject
    include SiteOtherProductsToolbar
    include SiteDownloadHelper
    include SiteForDevelopersHelper

    link(:download_now_button, xpath: '//a[@href = "/download.aspx?from=for-developers"]')
    link(:docspace_learn_more, xpath: '//a[@href = "/docspace.aspx?from=for-developers"]')
    link(:docspace_api, xpath: '//a[@href = "https://api.onlyoffice.com/docspace/basic"]')
    link(:docspace_check_tutorial, xpath: '//a[contains(@href, "integrating-onlyoffice-docspace-into-a-single-page-application")]')
    link(:docs_integration_examples, xpath: '//a[@href = "https://api.onlyoffice.com/editors/demopreview"]')
    link(:docs_compare_api_wopi, xpath: '//a[@href = "/wopi-comparison.aspx"]')
    link(:docs_try_now, xpath: '//a[@href = "/download-docs.aspx?from=for-developers#docs-developer"]')
    link(:docs_learn_more, xpath: '//a[@href = "/developer-edition.aspx?from=for-developers" and @class="button bl"]')
    link(:docbuilder_check_examples, xpath: '//a[@href = "https://api.onlyoffice.com/docbuilder/integratingdocumentbuilder"]')
    link(:docbuilder_download_now, xpath: '//a[@href = "/download.aspx?from=for-developers"]')
    link(:docbuilder_source_code, xpath: '//a[@href = "https://github.com/ONLYOFFICE/DocumentBuilder"]')
    link(:available_plugins, xpath: '//a[contains(@href, "/app-directory") and @class="button tr"]')
    link(:workspace_find_out_more, xpath: '//a[@href = "https://api.onlyoffice.com/portals/basic"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(download_now_button_element)
      end
    end
  end
end
