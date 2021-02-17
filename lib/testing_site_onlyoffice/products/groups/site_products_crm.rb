# /crm.aspx
# https://user-images.githubusercontent.com/40513035/101342416-940a8f00-3893-11eb-9f44-727eaf88ffa8.png
require_relative '../modules/site_groups_xpath'

module TestingSiteOnlyoffice
  class SiteProductsCRM
    include PageObject
    include SiteGroupsXpath
    include SiteToolbar

    div(:crm_identification, xpath: "//div[contains(@class,'collaborationcrm')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { run_on_your_own_server_element.present? && crm_identification_element.present? }
    end
  end
end
