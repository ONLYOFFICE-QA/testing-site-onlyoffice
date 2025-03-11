# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /document-builder.aspx
  # https://user-images.githubusercontent.com/38238032/197171586-bdfe6a84-7673-47ee-8675-8c5b0390bca0.png
  class SiteForDevelopersDocBuilder
    include PageObject
    include SiteToolbar
    include SiteDownloadHelper

    link(:get_started_top, xpath: "//a[@class='button red' and contains(@href, '/docs/document-builder/get-started/overview/')]")
    link(:code_download_link, xpath: '//a[contains(@class, "code_download_link")]')
    link(:github_open_source, xpath: '//a[contains(@href, "github.com/ONLYOFFICE/DocumentBuilder")]')
    link(:read_documentaion_top, xpath: "(//a[contains(@href, '/docs/document-builder/get-started/overview/')])[2]")
    link(:read_documentaion_bottom, xpath: "(//a[contains(@href, '/docs/document-builder/get-started/overview/')])[3]")
    link(:download_now_bottom, xpath: '//div[@class="dbldb_block_download_button"]//a[@href="/download-builder.aspx"]')
    link(:docs_developer, xpath: '//p//a[contains(@href, "/developer-edition.aspx")]')
    link(:buy_now, xpath: '//div[@class="dbldisc_block_contact_button"]//a[@href="/developer-edition-prices.aspx"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(code_download_link_element)
      end
    end

    features_xpaths = {
      document_processing: '//div[contains(@class, "code_description_heading cdblock_1")]',
      spreadsheet_creation: '//div[contains(@class, "code_description_heading cdblock_2")]',
      presentation_creation: '//div[contains(@class, "code_description_heading cdblock_3")]',
      form_building: '//div[contains(@class, "code_description_heading cdblock_6")]',
      pdf_generating: '//div[contains(@class, "code_description_heading cdblock_5")]'
    }

    features_xpaths.each_with_index do |(feature, xpath), index|
      define_method(:"click_#{feature}_and_download_file") do
        @instance.webdriver.click_on_locator(xpath)
        @instance.webdriver.click_on_locator("(//a[contains(@class, 'code_download_link')])[#{index + 1}]")
      end
    end

    def click_get_started_top
      get_started_top_element.click
    end

    def click_download_now_bottom
      download_now_bottom_element.click
      SiteGetOnlyofficeDownloadDocBuilder.new(@instance)
    end

    def click_docs_developer
      docs_developer_element.click
      SiteForDevelopersDocDevEdition.new(@instance)
    end

    def click_buy_now
      buy_now_element.click
      SitePriceDocsDeveloper.new(@instance)
    end

    def opened_file_url
      @instance.webdriver.current_url
    end
  end
end
