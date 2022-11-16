# frozen_string_literal: true

require_relative 'modules/site_for_business_workspace_methods'

module TestingSiteOnlyoffice
  # /document-management.aspx
  # https://user-images.githubusercontent.com/40513035/101329886-032bb780-3883-11eb-853b-bd6945388f2b.png
  class SiteWorkspaceDocumentManager
    include PageObject
    include SiteForBusinessWorkspaceMethods
    include SiteToolbar

    root_xpath = '//div[@class="dm-fs-btn"]'
    link(:run_on_your_own_server, xpath: "#{root_xpath}/a[contains(@href,'download')]")
    link(:try_in_the_cloud, xpath: "#{root_xpath}/a[contains(@href,'registration')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(run_on_your_own_server_element) }
    end
  end
end
