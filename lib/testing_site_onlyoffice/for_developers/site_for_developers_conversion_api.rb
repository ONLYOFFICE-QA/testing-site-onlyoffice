# frozen_string_literal: true

module TestingSiteOnlyoffice
  # conversion-api.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/06d9b47e-435f-42de-976a-5d3b5208191a
  class SiteForDevelopersConversionAPI
    include PageObject
    include SiteDownloadHelper

    link(:get_started, xpath: "//a[contains(@class, 'button') and contains(@href, 'api.onlyoffice.com')]")
    link(:formats_link, xpath: "//a[contains(@href, '/additional-api/conversion-api/conversion-table')]")
    link(:api_documentation_link, xpath: "(//a[contains(@href, '/docs/docs-api/additional-api/conversion-api/')])[2]")
    link(:online_converter_link, xpath: "(//a[contains(@href, '/online-document-converter.aspx')])[2]")
    link(:security_measures_link, xpath: "(//div/a[contains(@href, '/security.aspx')])[2]")
    link(:download_docs_link, xpath: "//a[@id = 'docs_link']")
    link(:download_desktop_link, xpath: "//a[@id = 'desktop_link']")
    link(:download_mobile_link, xpath: "//a[@id = 'mobile_link']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(get_started_element)
      end
    end

    def click_online_converter_link
      online_converter_link_element.click
      ConvertPage.new(@instance)
    end

    def click_security_measures_link
      security_measures_link_element.click
      SiteFeaturesSecurity.new(@instance)
    end

    def click_download_docs_link
      download_docs_link_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def click_download_desktop_link
      download_desktop_link_element.click
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end

    def click_download_mobile_link
      download_mobile_link_element.click
      SiteMobileApps.new(@instance)
    end
  end
end
