# frozen_string_literal: true

require_relative '../for_developers/site_for_developers_doc_builder'
require_relative '../for_developers/site_for_developers_conversion_api'
require_relative '../features/docs/site_features_e_book_creator'

module TestingSiteOnlyoffice
  # developer-edition.aspx
  # https://user-images.githubusercontent.com/67409742/166101050-a8605bdb-d3be-4300-9376-cb57db77a93f.png
  class SiteForDevelopersDocDevEdition
    include PageObject
    include SiteDownloadHelper

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?("//*[@id='get-it-now__developer-edition__b__download-docs']") }
    end

    # features
    link(:text_document_editing, xpath: "//a[@class='link' and contains(@href, 'document-editor')]")
    link(:spreadsheet_editing, xpath: "//a[@class='link' and contains(@href, 'spreadsheet-editor')]")
    link(:digital_form_building, xpath: "//a[@class='link' and contains(@href, 'form-creator.aspx')]")
    link(:presentation_editing, xpath: "//a[@class='link' and contains(@href, 'presentation-editor.aspx')]")
    link(:pdf_editing_and_filling, xpath: "//a[@class='link' and contains(@href, 'pdf-editor.aspx')]")
    link(:e_book_creation, xpath: "//a[@class='link' and contains(@href, 'e-book.aspx')]")
    link(:document_building, xpath: "//a[@class='link' and contains(@href, 'document-builder.aspx')]")
    link(:document_conversion, xpath: "//a[@class='link' and contains(@href, 'conversion-api.aspx')]")


    features_links =
      { text_document_editing: SiteFeaturesDocumentEditor,
        spreadsheet_editing: SiteFeaturesSpreadsheetEditor,
        digital_form_building: SiteFeaturesFormCreator,
        presentation_editing: SiteFeaturesPresentationEditor,
        pdf_editing_and_filling: SiteFeaturesPDFReaderConverter,
        e_book_creation: SiteFeaturesEBookCreator,
        document_building: SiteForDevelopersDocBuilder,
        document_conversion: SiteForDevelopersConversionAPI }

    features_links.each_key do |link|
      define_method(:"click_#{link}") do
        xpath = send(:"#{link}_element")
        @instance.webdriver.click_on_locator(xpath)
        features_links[link].new(@instance)
      end
    end

    def check_button_get_it_developer?
      @instance.webdriver.click_on_locator("//div[@class='solutionspages_header_narrow']//a[contains(@href,'/download-docs.aspx')]")
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def check_button_developer_see_in_action?
      @instance.webdriver.click_on_locator("//div[@class='solutionspages_header_narrow']//a[@href='/see-it-in-action.aspx']")
      SiteFeaturesSeeItInAction.new(@instance)
    end

    def click_button_macros_and_plugins
      @instance.webdriver.click_on_locator("//a[contains(@href,'api.onlyoffice.com/plugin/basic')]")
    end

    def check_button_cross_browser_compatibility?
      @instance.webdriver.click_on_locator("//div[@class='sfb_gb_item block2']//a[contains(@href,'/document-editor-comparison.aspx')]")
      SiteCompareSuites.new(@instance)
    end

    def check_button_easy_deployment?
      @instance.webdriver.click_on_locator("//a[contains(@href,'/download-docs.aspx') and text() = 'Try now for free']")
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_button_external_access
      @instance.webdriver.click_on_locator("//a[contains(@href,'api.onlyoffice.com/editors/interactingoutside')]")
    end

    def check_button_wopi_support?
      @instance.webdriver.click_on_locator("//a[contains(@href,'/wopi-comparison.aspx')]")
      SiteWOPIComparison.new(@instance)
    end
    def check_button_get_started_self_hosted?
      @instance.webdriver.click_on_locator("//div[contains(@class, 'choice')]//a[@href='/download-docs.aspx']")
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_button_get_started_amazone_machine
      @instance.webdriver.click_on_locator("//a[contains(@href,'aws.amazon.com/marketplace')]")
    end

    def click_button_get_started_alibaba_image
      @instance.webdriver.click_on_locator("//a[contains(@href,'marketplace.alibabacloud.')]")
    end
  end
end


