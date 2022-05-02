# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /document-editor-comparison.aspx
  # https://user-images.githubusercontent.com/67409742/166252325-04996c21-9c2d-4734-ac23-477a18a3004d.png
  class SiteCompareSuites
    include PageObject

    div(:comparison_body, xpath: '//div[@class="editorcomparison_header"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(comparison_body_element) }
    end
  end
end
