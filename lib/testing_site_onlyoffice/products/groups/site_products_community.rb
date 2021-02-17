# /community.aspx
# https://user-images.githubusercontent.com/40513035/101331190-b052ff80-3884-11eb-8575-ebf4d6bf28fd.png
require_relative '../modules/site_groups_xpath'

module TestingSiteOnlyoffice
  class SiteProductsCommunity
    include PageObject
    include SiteGroupsXpath
    include SiteToolbar

    div(:community_identification, xpath: "//div[contains(@class,'collaborationcommunity')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        run_on_your_own_server_element.present? && community_identification_element.present?
      end
    end
  end
end
