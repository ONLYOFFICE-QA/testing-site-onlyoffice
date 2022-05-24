# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /workspace-enterprise.aspx
  # https://user-images.githubusercontent.com/67409742/169979972-db98916f-7843-4868-befe-e8a7ad198c1b.png
  class SiteEnterpriseEdition
    include PageObject

    div(:enterprise_edition, xpath: "//div[@id='workspaceenterprisepage']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(enterprise_edition_element)
      end
    end
  end
end
