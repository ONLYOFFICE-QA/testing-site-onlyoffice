# frozen_string_literal: true

require_relative '../modules/site_groups_xpath'
require_relative '../modules/site_products_methods'

module TestingSiteOnlyoffice
  # /crm.aspx
  # https://user-images.githubusercontent.com/40513035/101342416-940a8f00-3893-11eb-9f44-727eaf88ffa8.png
  class SiteProductsCRM
    include PageObject
    include SiteGroupsXpath
    include SiteProductsMethods
    include SiteToolbar

    div(:crm_identification, xpath: "//div[contains(@class,'collaborationcrm')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(run_on_your_own_server_element) && @instance.webdriver.element_present?(crm_identification_element) }
    end
  end
end
