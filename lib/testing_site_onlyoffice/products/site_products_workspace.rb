# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Products & Features -> Onlyoffice Workspace
  # https://user-images.githubusercontent.com/40513035/100944239-e48a9100-350f-11eb-8259-2039d8176454.png
  class SiteProductsWorkspace
    include PageObject
    include SiteToolbar

    header_block = '//div[@class="wsp_header_block1"]'
    link(:workspace_try_in_the_cloud, xpath: "#{header_block}//a[@href='/registration.aspx?from=workspace']")
    link(:workspace_run_on_your_own_server,
         xpath: "#{header_block}//a[@href='/download-commercial.aspx?from=workspace#workspace']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { workspace_try_in_the_cloud_element.present? }
    end
  end
end
