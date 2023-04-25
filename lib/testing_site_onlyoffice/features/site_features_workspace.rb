# frozen_string_literal: true

require_relative 'workspace/modules/site_for_business_workspace_methods'
module TestingSiteOnlyoffice
  # /workspace.aspx
  # https://user-images.githubusercontent.com/40513035/100944239-e48a9100-350f-11eb-8259-2039d8176454.png
  class SiteFeaturesWorkspace
    include PageObject
    include SiteToolbar
    include SiteForBusinessWorkspaceMethods

    header_block = '//div[@class="wsp_header_block1"]'
    link(:workspace_try_in_the_cloud, xpath: "#{header_block}//a[@href='/registration.aspx?from=workspace']")
    link(:workspace_run_on_your_own_server,
         xpath: "#{header_block}//a[contains(@href, 'download-workspace')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(workspace_run_on_your_own_server_element) }
    end
  end
end
