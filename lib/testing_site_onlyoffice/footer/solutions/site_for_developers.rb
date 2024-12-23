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

    div(:top_banner, xpath: '//div[@class = "dev_header"]')
    link(:docspace_learn_more, xpath: '//a[@href = "/docspace.aspx?from=for-developers"]')
    link(:docspace_api, xpath: '//a[contains(@href, "api.onlyoffice.com/docspace")]')
    link(:docspace_check_tutorial, xpath: '//a[contains(@href, "integrating-onlyoffice-docspace-into-a-single-page-application")]')
    link(:docs_integration_examples, xpath: '//a[@href = "https://api.onlyoffice.com/editors/demopreview"]')
    link(:docs_open_wopi, xpath: '//a[contains(@href, "/docs-api/using-wopi/")]')
    link(:docs_open_api, xpath: '//a[contains(@href, "/docs-api/using-wopi/")]')
    link(:docs_try_now, xpath: '//a[@href = "/download-docs.aspx?from=for-developers#docs-developer"]')
    link(:docs_learn_more, xpath: '//a[@href = "/developer-edition.aspx" and @class="button red"]')
    link(:docbuilder_read_documentaion, xpath: '//a[@href = "https://api.onlyoffice.com/docs/document-builder/get-started/overview/"]')
    link(:docbuilder_download_now, xpath: '//a[@href = "/download.aspx?from=for-developers"]')
    link(:docbuilder_source_code, xpath: '//a[@href = "https://github.com/ONLYOFFICE/DocumentBuilder"]')
    link(:available_plugins, xpath: '//a[contains(@href, "/app-directory") and @class="button white_opacity"]')
    link(:workspace_find_out_more, xpath: '//a[contains(@href, "api.onlyoffice.com/portals/workspaceapi")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(top_banner_element)
      end
    end
  end
end
