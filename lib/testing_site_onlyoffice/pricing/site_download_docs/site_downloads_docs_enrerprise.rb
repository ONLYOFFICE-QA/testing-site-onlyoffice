# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Downloads connectors docs enterprise for try it free
  # https://user-images.githubusercontent.com/67409742/142833499-b3c6eb80-df8d-468b-ae34-3f5c08f7ad95.png
  class DownloadsDocsEnterprise
    include PageObject

    div(:docs_enterprise_connectors, xpath: "//div[@class='dwn-mp-docs-enterprise']")
    element(:title_docs_enterprise, xpath: "//div[@class='dwn-mp-docs-enterprise']/h2")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        docs_enterprise_connectors_element.present?
      end
    end

    def title_docs_enterprise
      @instance.webdriver.get_text(title_docs_enterprise_element)
    end
  end
end
