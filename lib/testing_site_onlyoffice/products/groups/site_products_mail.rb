# /mail.aspx
# https://user-images.githubusercontent.com/40513035/101343337-e8fad500-3894-11eb-82ab-3475aa336020.png
require_relative '../modules/site_groups_xpath'

module TestingSiteOnlyoffice
  class SiteProductsMail
    include PageObject
    include SiteGroupsXpath
    include SiteToolbar

    div(:mail_identification, xpath: "//div[contains(@class,'collaborationmail')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { run_on_your_own_server_element.present? && mail_identification_element.present? }
    end
  end
end
