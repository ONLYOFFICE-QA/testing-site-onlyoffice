# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /best-google-docs-alternative.aspx
  # https://github.com/user-attachments/assets/cd45cadf-c5ef-4399-a256-8d4deda4b006
  class ComparisonGoogle
    include PageObject
    include SiteDownloadHelper

    link(:get_docs_top, xpath: '//a[contains(@href, "download.aspx?from=comparison#docs-enterprise")]')
    div(:watch_presentation, xpath: '//div[contains(@class, "ecp_presentation_block")]')
    link(:read_instruction, xpath: '//a[contains(@class, "ecp_link_to_instruction")]')
    link(:get_onlyoffice_docs, xpath: "//a[contains(@class, 'button red') and @href='/download-docs.aspx']")
    link(:try_in_the_cloud, xpath: "//a[contains(@class, 'button gray') and @href='/registration.aspx?from=comparison']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(get_docs_top_element) }
    end

    def click_watch_presentation
      watch_presentation_element.click
    end

    def click_read_instruction
      read_instruction_element.click
    end

    def click_get_onlyoffice_docs
      get_onlyoffice_docs_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def click_try_in_the_cloud
      try_in_the_cloud_element.click
      SiteDocSpaceSignUp.new(@instance)
    end
  end
end
