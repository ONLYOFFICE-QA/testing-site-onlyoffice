# frozen_string_literal: true

require_relative '../marketplace/site_features_marketplace'
require_relative '../../modules/site_editors_links_checking_helper'
require_relative 'modules/site_features_docs_overview_helper'

module TestingSiteOnlyoffice
  # /office-suite.aspx
  # https://user-images.githubusercontent.com/38238032/200776135-b199c1ad-2fa1-44fd-915c-ce256f4fe7ac.png
  class SiteFeaturesDocsOverview
    include SiteFeaturesDocsOverviewHelper
    include SiteEditorsLinksCheckingHelper
    include PageObject

    link(:get_it_now_top, xpath: '//a[contains(@class, "get_in")]')
    link(:see_it_in_action, xpath: '//a[contains(@href, "see-it-in-action.aspx") and contains(@class, "button")]')
    link(:start_free_account, xpath: '//div[contains(@class, "sb_docspace")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(get_it_now_top_element) }
    end
  end
end
