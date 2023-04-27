# frozen_string_literal: true

require_relative 'modules/site_groups_xpath'
require_relative 'modules/site_for_business_workspace_methods'

module TestingSiteOnlyoffice
  # /mail.aspx
  # https://user-images.githubusercontent.com/40513035/101343337-e8fad500-3894-11eb-82ab-3475aa336020.png
  class SiteWorkspaceMail
    include PageObject
    include SiteGroupsXpath
    include SiteForBusinessWorkspaceMethods
    include SiteToolbar

    div(:mail_identification, xpath: "//div[contains(@class,'collaborationmail')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(run_on_your_own_server_element) && @instance.webdriver.element_present?(mail_identification_element) }
    end
  end
end
