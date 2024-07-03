# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /best-microsoft-office-alternative.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/3ad4ebb2-6910-47da-b153-67920e1bee0e
  class ComparisonMSOffice
    include PageObject
    include SiteDownloadHelper

    link(:get_docs_top, xpath: '//a[contains(@href, "/download-docs.aspx?from=comparison")]')
    div(:watch_presentation, xpath: '//div[contains(@class, "ecp_presentation_block")]')
    link(:read_instruction, xpath: '//a[contains(@class, "ecp_link_to_instruction")]')
    link(:get_onlyoffice_docs, xpath: "//a[contains(@class, 'button red') and @href='/download-docs.aspx']")
    link(:try_in_the_cloud, xpath: "//a[contains(@class, 'button gray') and @href='/registration.aspx?from=comparison']")
    link(:private_room, xpath: "//a[@href='/private-rooms.aspx?from=comparison']")

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

    def click_private_room
      private_room_element.click
      DocspacePrivateRooms.new(@instance)
    end
  end
end
