# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /wopi-comparison.aspx
  # https://user-images.githubusercontent.com/67409742/166258130-3acea5b5-a398-47a6-9fa0-fc60705e95f6.png
  class SiteWOPIComparison
    include PageObject

    div(:wopi_comparison_body, xpath: '//div[@class="contentConteiner"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(wopi_comparison_body_element) }
    end
  end
end
