# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /docs-home-server.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/82f41f41-b188-4d29-936c-05f3bd0f9f70
  class SitePricingHomeUse
    include PageObject

    link(:buy_now_button, xpath: "//a[@data-id = 'ie-price-url-updated']")
    link(:try_free_docs, xpath: "//a[@href='/download-docs.aspx?from=homeserver#docs-enterprise']")
    link(:try_free_docspace, xpath: "//a[@href='/download-docspace.aspx?from=familypack#docspace-enterprise']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(buy_now_button_element) }
    end

    def click_buy_now_docspace
      buy_now_button_element.click
      Avangate.new(@instance)
    end

    def click_buy_now_docs
      buy_now_button_element.click
      StripePaymentPage.new(@instance)
    end

    def click_try_free_docs
      try_free_docs_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def click_try_free_docspace
      try_free_docspace_element.click
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end
  end
end
