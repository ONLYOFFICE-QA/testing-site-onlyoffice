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

    FEATURES_LINKS = {
      text_document_editing: {
        xpath: "//a[@class='link' and contains(@href, 'document-editor')]",
        class: SiteFeaturesDocumentEditor
      },
      spreadsheet_editing: {
        xpath: "//a[@class='link' and contains(@href, 'spreadsheet-editor')]",
        class: SiteFeaturesSpreadsheetEditor
      },
      digital_form_building: {
        xpath: "//a[@class='link' and contains(@href, 'form-creator.aspx')]",
        class: SiteFeaturesFormCreator
      },
      presentation_editing: {
        xpath: "//a[@class='link' and contains(@href, 'presentation-editor.aspx')]",
        class: SiteFeaturesPresentationEditor
      },
      pdf_editing_and_filling: {
        xpath: "//a[@class='link' and contains(@href, 'pdf-editor.aspx')]",
        class: SiteFeaturesPDFReaderConverter
      },
      e_book_creation: {
        xpath: "//a[@class='link' and contains(@href, 'e-book.aspx')]",
        class: SiteFeaturesEBookCreator
      },
      document_building: {
        xpath: "//a[@class='link' and contains(@href, 'document-builder.aspx')]",
        class: SiteForDevelopersDocBuilder
      },
      document_conversion: {
        xpath: "//a[@class='link' and contains(@href, 'conversion-api.aspx')]",
        class: SiteForDevelopersConversionAPI
      }
    }.freeze

    def click_link_by_feature(feature_key)
      feature_info = FEATURES_LINKS[feature_key]
      @instance.webdriver.move_to_element_by_locator(feature_info[:xpath])
      @instance.webdriver.wait_until { @instance.webdriver.element_visible?(feature_info[:xpath]) }
      @instance.webdriver.click_on_locator(feature_info[:xpath])
      feature_info[:class].new(@instance)
    end

    def check_button_get_it_developer?
      xpath = "//div[@class='solutionspages_header_narrow']//a[contains(@href,'/download-docs.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def check_button_developer_see_in_action?
      xpath = "//div[@class='solutionspages_header_narrow']//a[@href='/see-it-in-action.aspx']"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteFeaturesSeeItInAction.new(@instance)
    end

    def click_button_macros_and_plugins
      xpath = "//a[contains(@href,'api.onlyoffice.com/plugin/basic')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end

    def check_button_cross_browser_compatibility?
      xpath = "//div[@class='sfb_gb_item block2']//a[contains(@href,'/document-editor-comparison.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteCompareSuites.new(@instance)
    end

    def check_button_easy_deployment?
      xpath = "//a[contains(@href,'/download-docs.aspx') and text() = 'Try now for free']"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_button_external_access
      xpath = "//a[contains(@href,'api.onlyoffice.com/editors/interactingoutside')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end

    def check_button_wopi_support?
      xpath = "//a[contains(@href,'/wopi-comparison.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteWOPIComparison.new(@instance)
    end
    def check_button_get_started_self_hosted?
      xpath = "//div[contains(@class, 'choice')]//a[@href='/download-docs.aspx']"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_button_get_started_amazone_machine
      xpath = "//a[contains(@href,'aws.amazon.com/marketplace')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end

    def click_button_get_started_alibaba_image
      xpath = "//a[contains(@href,'marketplace.alibabacloud.')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end
  end
end
